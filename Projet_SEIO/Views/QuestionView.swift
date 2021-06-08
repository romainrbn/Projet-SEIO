//
//  QuestionView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 13/05/2021.
//

import SwiftUI
import SimpleToast

struct QuestionView: View {
    
    @State private var isSelected = false
    
    @Binding var index: Int
    @Binding var progress: Double
    @Binding var quizEnded: Bool
    @Binding var finalScore: Int
        
    @State private var showResultsButton = false
    @State private var selectedChoice = -1
    @State var question: Question
    @State private var showAlert = false
    @State private var buttonDisabled = false
    
    private let toastOptions = SimpleToastOptions(alignment: .top, hideAfter: 3, showBackdrop: false, backdropColor: Color.white.opacity(0.9), animation: .linear, modifierType: .scale)
    
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
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            // Ajout d'un retour haptique au choix d'une question
//                            UINotificationFeedbackGenerator().notificationOccurred(.success)
//
//                            updateQuestion(choiceIndex: i)
//                        }
                    }
                    .buttonStyle(OutlinedButtonStyle(color: .blue, shouldHaveBackgroundEnabled: self.selectedChoice == i))
                }
                
            }.padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 12) {
                Button("Suivant") {
                    if selectedChoice == -1 {
                        self.showAlert.toggle()
                    } else {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        updateQuestion(choiceIndex: self.selectedChoice)
                    }
                }
                .buttonStyle(ColoredButtonStyle(color: .accentColor))
                
                Button("Précédent") {
                    
                }
            }
            
        }
        .simpleToast(isShowing: $showAlert, options: toastOptions) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Veuillez choisir une option pour continuer.")
            }
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
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
            buttonDisabled = false
            question = Question.allQuestions[index]
        }
    }
}
