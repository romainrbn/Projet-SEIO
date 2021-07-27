//
//  Question.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 13/05/2021.
//

// Créé une question 

import Foundation

struct Question: Identifiable, Decodable {
    var id: Int
    var intitule: String
    var titre: String?
    var choix: [String]
    var scorable: Bool
    
    static let allQuestions = Bundle.main.decode([Question].self, from: "questions.json")
}
