//
//  QuestionnaireView.swift
//  Projet_SEIO
//
//  Created by Romain Rabouan on 04/06/2021.
//

import SwiftUI

struct QuestionnaireView: View {
    @Binding var showFlag: Bool
    @State private var scores: [Int] = []
    @State private var quizEnded = false
    @State private var questionNumber = 0
    @State private var progress = 0.0
    @State private var allQuestions = Question.allQuestions.count
    @State private var showAlert = false
    @State var hasOptionSelected = false
    @State var selectedIndex = -1
    @State var isEnding = false
    @State private var showResultsSheet = false
    @AppStorage("doctorEmail") var doctorEmail: String = ""
    @AppStorage("rememberMe") var rememberMe = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical) {
                    ZStack {
                        VStack {
                            VStack {
                                VStack(spacing: 20) {
                                    HStack(alignment: .center) {
                                        Text("Diagnostic")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            self.showFlag.toggle()
                                        }) {
                                            Image(systemName: "xmark")
                                                .imageScale(.large)
                                                .font(Font.headline.weight(.bold))
                                        }
                                    }
                                    .padding(.top, proxy.safeAreaInsets.top)
                                    
                                    VStack {
                                        HStack {
                                            Text(String(format: NSLocalizedString("%d sur %d", comment: ""), questionNumber+1, allQuestions))
                                                .font(.system(.subheadline, design: .rounded))
//                                            Text("\(questionNumber+1) sur \(allQuestions)")
                                                
                                            Spacer()
                                        }
                                        
                                        ProgressView("", value: progress, total: 1)
                                            .foregroundColor(.white)
                                            .accentColor(.white)
                                            .padding(.bottom)
                                            .animation(.linear)
                                    }.padding(.top)
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            .padding(.bottom, 20)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 161/255, blue: 1), Color.accentColor]), startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1, y: 0)).edgesIgnoringSafeArea([.top, .bottom]))
                            
                            VStack(spacing: 0) {
                                Spacer()
                                
                                ZStack(alignment: .top) {
                                    Rectangle()
                                        .frame(width: proxy.size.width)
                                        .foregroundColor(Color("BackgroundPlain"))
                                    
                                    VStack(spacing: 12) {
                                        
                                        Text(Question.allQuestions[questionNumber].intitule)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .padding(.top)
                                        
                                        if let titre = Question.allQuestions[questionNumber].titre {
                                            Text(titre)
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal)
                                        }
                                        
                                        Divider()
                                        
                                        VStack(spacing: 0) {
                                            Group {
                                                ForEach(0..<Question.allQuestions[questionNumber].choix.count, id: \.self) { i in
                                                    Button(action: {
                                                        self.selectedIndex = i
                                                        
                                                        withAnimation {
                                                            self.hasOptionSelected = true
                                                        }
                                                        
                                                    }) {
                                                        QuizReponseView(title: Question.allQuestions[questionNumber].choix[i], selected: .constant(selectedIndex == i))
                                                            
                                                    }
                                                    .id("button\(i)")
                                                    .background(selectedIndex == i ? Color.accentColor : Color("BackgroundSystem"))
                                                    .padding(.bottom, i == (Question.allQuestions[questionNumber].choix.count - 1) ? 10 : 0)
                                                }
                                            }
                                        }
                                    }
                                    .background(Color("BackgroundSystem"))
                                    .cornerRadius(8)
                                    .shadow(radius: 10.0)
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 15) {
                                    if(hasOptionSelected) {
                                        Button(action: isEnding ? endTapped : nextTapped) {
                                            HStack(alignment: .center, spacing: 20) {
                                                Text(isEnding ? "Fin du diagnostic" : "Suivant")
                                                Image(systemName: "arrow.right")
                                            }
                                            .padding()
                                            .foregroundColor(Color.white)
                                            .background(Color.accentColor)
                                            .clipShape(Capsule())
                                            .padding()
                                            .id(8)
                                        }
                                        .transition(.move(edge: .bottom))
                                    }
                                    
                                    if(questionNumber >= 1) {
                                        Button("← Précédent") {
                                            backTapped()
                                        }
                                    }
                                }
                            }.edgesIgnoringSafeArea(.bottom)
                        }
                    }
                    .frame(minHeight: proxy.size.height)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            progress = 1/Double(allQuestions)
        }
        .sheet(isPresented: $showResultsSheet) {
            if !rememberMe {
                doctorEmail = ""
            }
        } content: {
            ResultsView(score: scores.reduce(0, +), showFlag: $showResultsSheet)
        }

    }
    
    func nextTapped() {
        
        guard hasOptionSelected else { return }
        
        hasOptionSelected = false
        
        isEnding = (questionNumber == allQuestions - 2)
        
        if(questionNumber < allQuestions - 1) {
            if questionNumber == self.scores.count {
                if(Question.allQuestions[questionNumber].scorable) {
                    self.scores.append(selectedIndex)
                } else {
                    self.scores.append(0) // question qui ne compte pas dans le score
                }
            } else {
                if(Question.allQuestions[questionNumber].scorable) {
                    self.scores[questionNumber] = selectedIndex
                } else {
                    self.scores[questionNumber] = 0
                }
            }
            selectedIndex = -1
            withAnimation {
                progress += (1/Double(allQuestions))
            }
            questionNumber += 1
            print(scores)
        } else {
            self.isEnding = true
            print("Fin du diagnostic")
        }
    }
    
    func endTapped() {
        guard hasOptionSelected else { return }
        
        if scores.count == allQuestions {
            self.scores[allQuestions-1] = selectedIndex
        } else {
            self.scores.append(selectedIndex)
        }
        
        hasOptionSelected = false
        selectedIndex = -1
        
        for score in 0..<scores.count {
            let index = scores[score]
            print(Question.allQuestions[score].choix[index])
            UserDefaults.standard.set(Question.allQuestions[score].choix[index], forKey: "reponse\(score)")
            UserDefaults.standard.set(Question.allQuestions[score].intitule, forKey: "intitule\(score)")
        }
        
        self.showResultsSheet.toggle()
    }
    
    func backTapped() {
        isEnding = false
        hasOptionSelected = true
        selectedIndex = self.scores[questionNumber-1]
        if(questionNumber >= 1) {
            withAnimation {
                progress -= (1/Double(allQuestions))
            }
            questionNumber -= 1
        }
    }
}

struct ButtonsOptionsView: View {
    @Binding var selectedIndex: Int
    @Binding var questionNumber: Int
    @State var scrollProxy: ScrollViewProxy
    @Binding var hasOptionSelected: Bool
    var body: some View {
        VStack(spacing: 0) {
            Group {
                ForEach(0..<Question.allQuestions[questionNumber].choix.count, id: \.self) { i in
                    Button(action: {
                        scrollProxy.scrollTo(Question.allQuestions[questionNumber].choix.count - 1)
                        self.selectedIndex = i
                        
                        withAnimation {
                            self.hasOptionSelected = true
                        }
                        
                    }) {
                        QuizReponseView(title: Question.allQuestions[questionNumber].choix[i], selected: .constant(selectedIndex == i))
                            
                    }
                    .id("button\(i)")
                    .background(selectedIndex == i ? Color.accentColor : Color("BackgroundSystem"))
                    .padding(.bottom, i == (Question.allQuestions[questionNumber].choix.count - 1) ? 10 : 0)
                }
            }
        }
    }
}
