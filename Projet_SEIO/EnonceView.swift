//
//  EnonceView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 08/06/2021.
//

import SwiftUI

//struct EnonceView: View {
//    @State var scrollProxy: ScrollViewProxy
//    @State var selected = false
//    @Binding var selectedIndex: Int
//    @Binding var hasOptionSelected: Bool
//    @Binding var currentIndex: Int
//    var body: some View {
//        VStack(spacing: 12) {
//            
//            Text(Question.allQuestions[questionNumber].intitule)
//                .font(.headline)
//                .fontWeight(.medium)
//                .padding(.top)
//            
//            if let titre = Question.allQuestions[questionNumber].titre {
//                Text(titre)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//            }
//            
//            Divider()
//            
//            VStack(spacing: 0) {
//                Group {
//                    ForEach(0..<Question.allQuestions[questionNumber].choix.count, id: \.self) { i in
//                        Button(action: {
//                            self.selectedIndex = i
//                            
//                            withAnimation {
//                                self.hasOptionSelected = true
//                            }
//                            scrollProxy.scrollTo("nextButton")
//                        }) {
//                            QuizReponseView(title: Question.allQuestions[questionNumber].choix[i], selected: .constant(selectedIndex == i))
//                                
//                        }
//                        .background(selectedIndex == i ? Color.accentColor : Color("BackgroundSystem"))
//                        .padding(.bottom, i == (Question.allQuestions[questionNumber].choix.count - 1) ? 10 : 0)
//                    }
//                }
//            }
//            
//        }
//        .background(Color("BackgroundSystem"))
//        .cornerRadius(8)
//        .shadow(radius: 10.0)
//    }
//}
//
//
