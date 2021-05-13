//
//  DiagnosticView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 09/04/2021.
//

import SwiftUI

struct DiagnosticView: View {
    @Binding var showFlag: Bool
    @State private var finalScore = 0
    @State private var progress = 0.0
    @State private var quizEnded = false
    @State private var questionNumber = 0
    @State private var totalQuestions = Question.allQuestions.count

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                if(!quizEnded) {
                    ProgressView("", value: progress, total: 1)

                    HStack {
                        Text("Question \(questionNumber+1)/\(totalQuestions)")
                            .font(.title)
                            .fontWeight(.medium)
                        Spacer()
                    }.padding(.top)
                    .padding(.leading, 20)
                    
                    QuestionView(index: $questionNumber, progress: $progress, quizEnded: $quizEnded, finalScore: $finalScore, question: Question.allQuestions[0])
                    
                    Spacer()
                } else {
                    Text("Quiz terminé")
                    Text("Score final : \(finalScore)")
                }
            }
                .navigationTitle("Diagnostic")
                .navigationBarItems(trailing: Button(action: {
                    self.showFlag.toggle()
                }) {
                    Text("Annuler")
                })
        }
    }
}

struct QuestionView: View {
    
    @State private var isSelected = false
    
    @Binding var index: Int
    @Binding var progress: Double
    @Binding var quizEnded: Bool
    @Binding var finalScore: Int
        
    @State private var showResultsButton = false
    @State private var selectedChoice = -1
    @State var question: Question
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(question.intitule)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            if let titre = question.titre {
                Text(titre)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
            }
            
            VStack(spacing: 13) {
                
                ForEach(0 ..< question.choix.count, id: \.self) { i in
                    Button(question.choix[i]) {
                        self.isSelected = true
                        self.selectedChoice = i
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            updateQuestion(choiceIndex: i)
                        }
                    }
                    .buttonStyle(OutlinedButtonStyle(color: .blue, shouldHaveBackgroundEnabled: self.selectedChoice == i))
                }
                
            }.padding(.horizontal)
            
            Spacer()
        }
    }
    
    /**
        Met à jour la question.
        - Parameter choiceIndex: L'index du choix sélectionné dans la question passée.
    */
    func updateQuestion(choiceIndex: Int) {
        // On remet l'option selectionnée à -1 pour n'en sélectionner aucune sur la page suivante.
        selectedChoice = -1
        
        // On remet 'isSelected' à 'false' car la prochaine question n'est pas encore répondue.
        isSelected = false
        
        // On incrémente le progress du quizz
        progress += (1 / Double(Question.allQuestions.count))
        
        // Dans le cas ou la question est marquée comme scorable (compte dans le décompte des points)
        if question.scorable {
            // On incrémente le score
            finalScore += choiceIndex
        }
        
        // On vérifie si le quizz est terminé
        if index > (Question.allQuestions.count - 2) {
            quizEnded = true
        } else {
            // Si le quizz n'est pas terminé, on incrémente l'index et on change la question.
            index += 1
            question = Question.allQuestions[index]
        }
    }
}
