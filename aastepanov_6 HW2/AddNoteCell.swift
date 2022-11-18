//
//  AddNoteCell.swift
//  aastepanov_6 HW2
//
//  Created by Алексей Степанов on 2022-11-15.
//

import UIKit

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    public var delegate: NotesStackProtocol?
    private var textView = UITextView()
    public var addButton = UIButton()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(140)
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.alpha = 0.5
        addButton.isEnabled = true
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left, .top, .right, .bottom], 16)
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if (!textView.text.isEmpty) {
            delegate?.addNewNote(note: ShortNote(text: textView.text))
            textView.text = ""
        }
    }
}
