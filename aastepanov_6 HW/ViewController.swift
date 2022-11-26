//
//  ViewController.swift
//  aastepanov_6 HW
//
//  Created by Алексей Степанов on 2022-10-05.
//

import UIKit

class ViewController: UIViewController, ObserverProtocol {
    private let colorPaletteView = ColorPaletteView()
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton(type: .system)
    private let notesViewController = NotesViewController()
    private var buttonsSV = UIStackView()
    private var value: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorPalette()
        colorPaletteView.delegate = self
    }

    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        applyShadow(incrementButton)
        view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: view.centerYAnchor)
        incrementButton.pin(to: view, [.left, .right], 24)
        incrementButton.addTarget(self, action:
        #selector(incrementButtonPressed), for: .touchUpInside)
    }

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton, 48)
        valueLabel.pinCenterX(to: view)
    }

    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.transition(with: view, duration: 0.15,options: .transitionCrossDissolve, animations: {
            self.valueLabel.text = "\(self.value)"
            self.updateCommentLabel(value: self.value)
        }, completion: nil)
    }

    private func setupCommentView() {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to:
        view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: view, [.left, .right], 24)
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top, .left, .bottom, .right], 16)
    }

    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        case 100...110:
            commentLabel.text = "💋"
        default:
            break
        }
    }

    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo:button.widthAnchor).isActive = true
        applyShadow(button)
        return button
    }

    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action:#selector(paletteButtonPressed), for: .touchUpInside)
        let notesButton = makeMenuButton(title: "🗒️")
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        let newsButton = makeMenuButton(title: "📰")

        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually

        view.addSubview(buttonsSV)
        buttonsSV.pin(to: view, [.left, .right], 24)
        buttonsSV.pinBottom(to: view, 48)
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func notesButtonPressed() {
        self.present(notesViewController, animated: true, completion: nil)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    private func applyShadow(_ button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }
    
    private func setupColorPalette() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        colorPaletteView.pinTop(to: incrementButton, 54)
        colorPaletteView.pinBottom(to: buttonsSV, Int(view.frame.width - 72) / 3 + 6)
        colorPaletteView.pin(to: view, [.left, .right], 24)
    }
    
    func howColorChanged(_ palette: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = palette.chosenColor
        }
    }
}
