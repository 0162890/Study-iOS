import UIKit
import SafariServices

class SecondVideoViewController: UIViewController {
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Video>
    private lazy var dataSource = makeDataSource()
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Video>
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var videos = Video.allVideos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.applySnapshot(animatingDifferences: false)
    }
    
    private func setup() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "검색어를 입력하세요."
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, video -> UICollectionViewCell? in
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell
            videoCell?.video = video
            return videoCell
        }
        
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos)
        self.dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension SecondVideoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = self.dataSource.itemIdentifier(for: indexPath)
        
        guard let link = video?.link else { return }
        
        let safariViewController = SFSafariViewController(url: link)
        present(safariViewController, animated: true, completion: nil)
    }
}

extension SecondVideoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateVideoList(with: searchText)
        self.applySnapshot()
    }
    
    func updateVideoList(with text: String) {
        if text == "" {
            self.videos = Video.allVideos
        } else {
            self.videos = Video.allVideos.filter { video in
                return video.title.lowercased().contains(text.lowercased())
            }
        }
    }
}
