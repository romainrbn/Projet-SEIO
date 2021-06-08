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
    @State private var allQuestions = Question.allQuestions.count
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                if(!quizEnded) {
                    ProgressView("", value: progress, total: 1)

                    HStack {
                        Text("Question \(questionNumber+1)/\(allQuestions)")
                            .font(.title)
                            .fontWeight(.medium)
                        Spacer()
                    }.padding(.top)
                    .padding(.leading, 20)
                    
                    QuestionView(index: $questionNumber, progress: $progress, quizEnded: $quizEnded, finalScore: $finalScore, question: Question.allQuestions[0])
                    
                    Spacer()
                } else {
                    ResultView(score: finalScore)
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Attention"),
                    message: Text("Les réponses ne seront pas sauvegardées. Continuer ?"),
                    primaryButton: .destructive(Text("Continuer"), action: { self.showFlag.toggle() }) ,
                    secondaryButton: .cancel(Text("Annuler"))
                )
            })
                .navigationTitle("Diagnostic")
                .navigationBarItems(trailing: Button(action: {
                    self.showAlert.toggle()
                }) {
                    Text("Annuler")
                })
        }
    }
}

