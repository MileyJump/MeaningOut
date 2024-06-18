//
//  SearchResultsViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import Alamofire


class SearchResultsViewController: UIViewController {
    
    var searchResult: String = "키보드"
    var searchResultCount: Int = 0 {
        didSet {
            updateSearchtotal()
        }
    }
    
    var likeStatuses: [LikeStatus] = [] {
        didSet {
            saveLikeStatuses()
        }
    }
    
    // 페이지네이션
    var page = 1
    
    // 현재 선택된 버튼 저장
    var selectedButton: UIButton?
    
    var shoppingData: [Items] = []
    var shoppingList: [Items] = []
    
    
    // MARK: - UI
    
    lazy var searchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customMainColor
        label.text = "\(searchResultCount)개의 검색 결과"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var accuracyButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "정확도", cornerRadius: 16)
        button.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dateButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "날짜순", cornerRadius: 16)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var highPriceButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격높은순", cornerRadius: 16)
        button.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var lowestPriceButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격낮은순", cornerRadius: 16)
        button.addTarget(self, action: #selector(lowestPriceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width)
        layout.minimumLineSpacing = cellSpacing - 10
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        callRequest(query: searchResult, sortText: "sim")
        loadLikeStatuses()
    }
    
    
    // MARK: - SetUpAddTarget
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        likeStatuses[sender.tag].isLiked.toggle() // 좋아요 상태 토글
        
        let likeButtonImage = likeStatuses[sender.tag].isLiked ? "like_selected" : "like_unselected"
        sender.setImage(UIImage(named: likeButtonImage), for: .normal)
        
        updateLikedItemCount()
    }
    
    
    @objc func accuracyButtonTapped() {
        print("정확도 버튼이 클릭되었습니다.")
        updateButtonState(button: accuracyButton)
        callRequest(query: searchResult, sortText: "sim")
        collectionView.reloadData()
    }
    
    @objc func dateButtonTapped() {
        print("날짜순 버튼이 클릭되었습니다.")
        updateButtonState(button: dateButton)
        callRequest(query: searchResult, sortText: "date")
    }
    
    @objc func highPriceButtonTapped() {
        print("가격높은순 버튼이 클릭되었습니다.")
        
        callRequest(query: searchResult, sortText: "dsc")
        updateButtonState(button: highPriceButton)
        collectionView.reloadData()
    }
    
    @objc func lowestPriceButtonTapped () {
        print("가격낮은순 버튼이 클릭되었습니다.")
        
        callRequest(query: searchResult , sortText: "asc")
        updateButtonState(button: lowestPriceButton)
        collectionView.reloadData()
    }
    
    
    func updateButtonState(button: UIButton) {
        guard button != selectedButton else { return } // 이미 선택된 버튼이면 리턴
        
        // 선택된 버튼의 색상 변경
        button.backgroundColor = .customDarkGray
        button.setTitleColor(.white, for: .normal)
        
        // 이전에 선택된 버튼의 색상 원래대로 변경
        selectedButton?.backgroundColor = .white
        selectedButton?.setTitleColor(.black, for: .normal)
        
        // 선택된 버튼 업데이트
        selectedButton = button
    }
    
    // MARK: - 기능

    
    // 선택된 좋아요 수 계산 및 표시
    func updateLikedItemCount() {
        
        let likedItemCount = likeStatuses.filter { $0.isLiked }.count
        UserDefaults.standard.set(likedItemCount, forKey: "like")
    }
    
    // 좋아요 상태 저장 ,,
    func saveLikeStatuses() {
        print("돼..?")
        do {
            let encoded = try JSONEncoder().encode(likeStatuses)
            UserDefaults.standard.set(encoded, forKey: "likeStatuses")
        } catch {
            print(" 오류입니다 : \(error.localizedDescription)") // 오류를 알아듣기 쉽게 만들어줌ㅎ
        }
    }
    
    // 좋아요 상태 불러오기
    func loadLikeStatuses() {
        print(#function)
        let decoder = JSONDecoder()
        do {
            if let savedData = UserDefaults.standard.data(forKey: "likeStatuses") {
                let decoded = try decoder.decode([LikeStatus].self, from: savedData)
                print(decoded)
                likeStatuses = decoded
            } else {
                // 저장된 데이터가 없을 경우 초기화 혹은 기본값 설정
                likeStatuses = Array(repeating: LikeStatus(), count: shoppingData.count)
                print("데이터 없어요")
            }
        } catch {
            print("오류입니다! : \(error.localizedDescription)") // localizedDescription : 오류를 알아듣기 쉽게 해준다!
            // 여기서 필요한 추가적인 오류 처리를 할 수 있습니다.
        }
    }
    
    // URL 요청
    func callRequest(query: String, sortText: String) {
        let url = "\(APIURL.naverShoppingURL)query=\(query)&display=30&sort=\(sortText)"
        
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverKey
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ShoppingModel.self) { response in
            
            switch response.result {
            case .success(let value):

                
                if self.page == 1 {
                    self.shoppingData = value.items // 첫 페이지 요청일 경우 데이터 초기화
                } else {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    self.shoppingData = value.items // 첫 페이지 요청일 경우 데이터 초기화
                    self.shoppingData.append(contentsOf: value.items) // 다음 페이지일 경우 데이터 추가
                    
                }
                self.searchResultCount = value.total
                self.collectionView.reloadData() // UI 업데이트
                         
                
                self.likeStatuses = Array(repeating: LikeStatus(), count: self.shoppingData.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func updateSearchtotal() {
        
        let count = Int(searchResultCount)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 3자리마다 콤마를 추가하는 형식
        
        if let result = formatter.string(for: count) {
            searchResultLabel.text = result + "개의 검색 결과"
        }
    }
    
    // MARK: - View

    
    func configureView() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .customLightGray
        appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = searchResult
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        view.addSubview(searchResultLabel)
        view.addSubview(accuracyButton)
        view.addSubview(dateButton)
        view.addSubview(highPriceButton)
        view.addSubview(lowestPriceButton)
        view.addSubview(collectionView)
    }
    
    
    func configureLayout() {
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabel.snp.bottom).offset(15)
            make.leading.equalTo(searchResultLabel.snp.leading)
            make.height.equalTo(35)
            make.width.equalTo(55)
        }
        
        dateButton.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(accuracyButton)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(10)
        }
        
        highPriceButton.snp.makeConstraints { make in
            make.height.verticalEdges.equalTo(accuracyButton)
            make.width.equalTo(80)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
        }
        
        lowestPriceButton.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(highPriceButton)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - CollectionView Delegate, DataSource

extension SearchResultsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if shoppingData.count - 2 == item.row {
                page += 1
                callRequest(query: searchResult, sortText: "sim")
            }
        }
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.identifier, for: indexPath) as! SearchResultsCollectionViewCell
        cell.configureCell(shoppingData[indexPath.row])
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        
        cell.index = indexPath.row
        
        if likeStatuses[indexPath.row].isLiked == true {
            cell.isTouched = true
        } else {
            cell.isTouched = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailProductViewController()
        vc.link = shoppingData[indexPath.row].link
        vc.productName = shoppingData[indexPath.row].title
        vc.likeButtonType = likeStatuses[indexPath.row].isLiked
        print(vc.likeButtonType)
        navigationController?.pushViewController(vc, animated: true)
    }
}
