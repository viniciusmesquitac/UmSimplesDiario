//
//  BackgroundSelectionCell.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 15/05/21.
//

import UIKit

protocol BackgroundsDelegate: AnyObject {
    func didSelectBackground(at index: Int)
}

class BackgrondsSelectionCell: UITableViewCell {

    static let identifier = String(describing: type(of: self))

    weak var delegate: BackgroundsDelegate?

    let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        return flowLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(BackgroundCell.self,
                                forCellWithReuseIdentifier: BackgroundCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
        self.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        buildViewHierarchy()
        setupConstraints()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.collectionView.reloadData()
    }

    func buildViewHierarchy() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - DataSource
extension BackgrondsSelectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let theme = traitCollection.userInterfaceStyle
        switch theme {
        case .dark:
            return Background.allCases.filter { $0.type == .darkMode || $0.type == .systemMode }.count
        case .light:
            return Background.allCases.filter { $0.type == .lightMode || $0.type == .systemMode }.count
        case .unspecified:
            return Background.allCases.filter { $0.type == .systemMode }.count
        @unknown default:
            fatalError()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BackgroundCell.identifier, for: indexPath) as? BackgroundCell else {
            return UICollectionViewCell()
        }
        let theme = traitCollection.userInterfaceStyle
        var background = Background.allCases[indexPath.row]
        switch theme {
        case .dark:
            background = Background.allCases.filter { $0.type == .darkMode || $0.type == .systemMode }[indexPath.row]
        case .light:
            background = Background.allCases.filter { $0.type == .lightMode || $0.type == .systemMode }[indexPath.row]
        case .unspecified:
            background = Background.allCases.filter { $0.type == .systemMode }[indexPath.row]
        @unknown default:
            fatalError()
        }
        cell.setImage(image: background)
        if background == InterfaceStyleManager.shared.background {
            cell.isSelected = true
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BackgroundCell else { return }
        for cell in collectionView.visibleCells {
            cell.isSelected = false
        }
        cell.isSelected = true
        delegate?.didSelectBackground(at: indexPath.row)
    }
}

// MARK: - CollectionViewCell
class BackgroundCell: UICollectionViewCell {

    static let identifier = String(describing: type(of: self))
    override var isSelected: Bool {
        didSet {
            self.imageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }

    let imageView: SDImageView = {
        let imageView = SDImageView()
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "noneBackground")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func setImage(image: Background) {
        imageView.image = UIImage(named: image.rawValue)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
