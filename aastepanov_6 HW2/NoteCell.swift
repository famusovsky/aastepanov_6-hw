//
//  NoteCell.swift
//  aastepanov_6 HW2
//
//  Created by Алексей Степанов on 2022-11-15.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var label = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        label.backgroundColor = .clear
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(label)
        label.pin(to: contentView, [.left, .right, .bottom, .top], 16)
    }
    
    public func configure(_ note: ShortNote) {
        label.text = note.text
    }
}
