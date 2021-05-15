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
        flowLayout.itemSize = CGSize(width: 72, height: 72)
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

    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
        return self.collectionView.contentSize
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
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BackgroundCell.identifier, for: indexPath) as? BackgroundCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BackgroundCell else { return }
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
        imageView.backgroundColor = .darkGray
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
