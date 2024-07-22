//
//  Theme.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 19-05-24.
//

import SwiftUI // No deberia importar algo de vista si este es parte del modelo

struct Theme {
    let name: String
    let emoji: Set<String>
    let numberOfPairs: Int?
    let color: Color
}
