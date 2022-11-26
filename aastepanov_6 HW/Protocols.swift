//
//  Protocols.swift
//  aastepanov_6 HW
//
//  Created by Алексей Степанов on 2022-10-27.
//

import UIKit

protocol ObserverProtocol: AnyObject {
    func howColorChanged(_ palette: ColorPaletteView)
}

protocol NotesStackProtocol: AnyObject {
    func addNewNote(note: ShortNote)
}
