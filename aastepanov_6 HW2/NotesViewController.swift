//
//  NotesViewController.swift
//  aastepanov_6 HW2
//
//  Created by Алексей Степанов on 2022-11-14.
//

import UIKit

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote(text: "amogus"), ShortNote(text: "S U S")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        let notesData = UserDefaults.standard.data(forKey: "Notes") ?? Data()
        if (!notesData.isEmpty) {
            let notes: [ShortNote] = try! JSONDecoder().decode([ShortNote].self, from: notesData)
            if (!notes.isEmpty) {
                dataSource = notes
            }
        }
        
        tableView.pin(to: self.view)
    }
    
    private func setupNavBar() {
        self.title = "Notes"
        
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissNotesController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc
    private func dismissNotesController() {
        dismiss(animated: true, completion: nil)
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}

extension NotesViewController: UITableViewDelegate { }
 
extension NotesViewController: NotesStackProtocol {
    func addNewNote(note: ShortNote) {
        dataSource.insert(note, at: 0)
        
        let notesData = try? JSONEncoder().encode(dataSource)
        UserDefaults.standard.set(notesData, forKey: "Notes")
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        
        let notesData = try? JSONEncoder().encode(dataSource)
        UserDefaults.standard.set(notesData, forKey: "Notes")
        
        tableView.reloadData()
    }
}

extension NotesViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                   indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
}
