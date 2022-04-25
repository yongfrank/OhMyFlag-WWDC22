import SwiftUI
import CoreData


struct FlagAndName {
    var flag: String
    var name: String
}
struct FrostedGlass: ViewModifier {
    
    func body(content: Content) -> some View {
        //        GeometryReader { geometry in
        content
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        
        //        }
        
        
    }
}
extension View {
    func frostedGlass() -> some View {
        modifier(FrostedGlass())
    }
}


struct QuizFlag: View {
    @FetchRequest(sortDescriptors: []) var flagQuiz: FetchedResults<FlagEntities>
    @Environment(\.managedObjectContext) var mocQuizFlag
    @State private var setThree = Set<Int>()
    @State private var arrayThree = [Int]()
    @State var correctAnswer = Int() {
        didSet {
//            print("now the correct is \(correctAnswer)")
        }
    }
    @State var isStarted = false
    
    @State var scoreTitle = "        "
    @State var playerScore = 0
    @State var buttonChoosed = 1
    @State var showingScore = true
    @State var roundCount = 1
    
    @State var a = Int()
    @State var b = Int()
    @State var c = Int()
    @State var isfirstTap = true
    
    @Environment(\.dismiss) var dismiss
    
    // Timer https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-a-timer-with-swiftui
    @State var timerDefault = 15
    @State var timerCount = Int()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingReset = false
    let timersOfTimerDefaults = [15, 30, 45, 60]
    
    
    @State var alertInGameLessThanThree = false
    
    //: Animation
    @State private var opacityAmount = 2.0
    
    @State private var animationAmountA = 0.0
    @State private var animationAmountB = 0.0
    @State private var animationAmountC = 0.0
    
    var body: some View {
        ZStack {
            //            RadialGradient(stops: [
            //                .init(color: .yellow, location: 0.3),
            //                .init(color: .blue, location: 0.3)
            //            ], center: .top, startRadius: 400, endRadius: 800)
            //                .ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack {
                    //                Spacer()
                    
                    // Start View
                    if !isStarted {
                        VStack() {
                            Text("🤡 Oh My Quiz")
                                .font(.largeTitle)
                                .padding(.bottom)
//                                .padding(.leading, 50)
                            VStack(alignment: .leading) {
                                
                                Text("🎮 Add 3 Flags\n\n✔️ Tap Right Flags\n\n🙉 Choose Play Time (Seconds)")
                                    .padding(.horizontal)
                                Picker("Time", selection: $timerDefault) {
                                    ForEach(timersOfTimerDefaults, id: \.self) {
                                        Text($0, format: .number)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .frame(maxWidth: 250)
//                                .padding(.leading, 20)
                            }
                            
                        }
                        .padding()
                        
                        Button("Play") {
                            if flagQuiz.count >= 3 {
                                isStarted = true
                            } else {
                                alertInGameLessThanThree = true
                            }
                            
                            if isStarted == true {
                                gameLogic()
                                timerCount = timerDefault
                                restartGame()
                                
                            }
                        }
                        
                        .frostedGlass()
                        .font(.largeTitle)
                        .frame(width: 150)
                        
                        
                    }
                    
                    // MARK: - Game View
                    if isStarted {
                        
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text("Round \(roundCount)")
                                
                                Spacer()
                                
                                Text("Score: \(playerScore)")
                                    .font(.title.bold())
                                
                            }
                            VStack {
                                Text("Tap the flag of ")
                                    .font(.title.weight(.bold))
                                Text("\(flagQuiz[correctAnswer].nameFlag)")
                                    .font(.largeTitle.weight(.heavy))
                                    .foregroundColor(.accentColor)
                                HStack {
                                    Button(flagQuiz[a].emojiFlag){
                                        flagTapped(a)
                                        withAnimation {
                                            animationAmountA += 360
                                            opacityAmount = 0.5
                                        }
                                    }
                                    .rotation3DEffect(.degrees(animationAmountA), axis: (x: 0, y: 1, z: 0))
                                    
                                    Button(flagQuiz[b].emojiFlag){
                                        flagTapped(b)
                                        withAnimation {
                                            animationAmountB += 360
                                            opacityAmount = 0.5
                                        }
                                    }
                                    .rotation3DEffect(.degrees(animationAmountB), axis: (x: 0, y: 1, z: 0))
                                    Button(flagQuiz[c].emojiFlag){
                                        flagTapped(c)
                                        withAnimation {
                                            animationAmountC += 360
                                            opacityAmount = 0.5
                                        }
                                    }
                                    .rotation3DEffect(.degrees(animationAmountC), axis: (x: 0, y: 1, z: 0))
                                }
                                .font(.system(size: geometry.size.width < geometry.size.height ? geometry.size.width * 0.2 : geometry.size.height * 0.2))
                                
                            }
                            .frostedGlass()
                            
                            Spacer()
                            VStack(alignment: .center){
                                Text(scoreTitle)
                                    .font(.largeTitle.weight(.heavy))
                                    .foregroundColor(scoreTitle == "✅ Bingo, That's right!" ? .white : .red)
                                //                            .frame(width: 300, alignment: .center)
                                    .padding()
                                HStack (alignment: .bottom) {
                                    if !isfirstTap {
                                        Button("Continue") {
                                            continueGame()
                                        }
                                        .font(.largeTitle)
                                        
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: geometry.size.width < geometry.size.height ? geometry.size.width * 0.75: geometry.size.height * 0.3)
                            .frostedGlass()
                            
                            
                            Spacer()
                            HStack {
                                VStack {
                                    if isStarted {
                                        Text("\(timerCount)")
                                            .onReceive(timer) { _ in
                                                if timerCount != 0 {
                                                    timerCount -= 1
                                                } else {
                                                    showingReset = true
                                                }
                                            }
                                    }
                                }
                                .buttonStyle(.bordered)
                                .frostedGlass()
                                .clipShape(Circle())
                                
                                
                            }
                            Button("Quit Game") {
                                isStarted = false
                            }
                            .padding()
                            //                            Spacer()
                            
                            
                            Spacer()
                        }
                        
                    } // end of if
                    
                }
                .padding(.horizontal)
                .alert("Add more flags 🫣", isPresented: $alertInGameLessThanThree) {
                    Button("Dismiss", role: .cancel){}
                }
                .alert("TIME'S UP", isPresented: $showingReset) {
                    Button("Play Again", role: .cancel, action: restartGame)
                    Button("Quit", role: .destructive) { isStarted = false }
                } message: {
                    Text("Final score: \(playerScore)")
                }
                .frame(width: geometry.size.width < geometry.size.height ? geometry.size.width * 0.9 : geometry.size.height * 0.8)
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                //: End of VStack
            } //: end of GeometryReader
        }
        .background(.darkBackground)
    } //: End of body
    struct FullScreenModalView: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            ZStack {
                Color.primary.edgesIgnoringSafeArea(.all)
                Button("Dismiss Modal") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    // MARK: - Function Time!
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "✅ Bingo, That's right!"
            //            if isStarted {}
            if isfirstTap {
                playerScore += 1
            }
        } else {
            scoreTitle = "❎ That's the flag of \(flagQuiz[number].nameFlag)"
        }
        
        buttonChoosed = number
        showingScore = true
        isfirstTap = false
    }
    
    func randomFlagfunc(_ moc: NSManagedObjectContext) -> FlagEntities? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FlagEntities")
        
        if let fetchRequestCount = try? moc.count(for: fetchRequest) {
            fetchRequest.fetchOffset = Int.random(in: 0...fetchRequestCount)
        }
        
        fetchRequest.fetchLimit = 1
        
        var fetchResults: [FlagEntities]?
        moc.performAndWait {
            fetchResults = try? fetchRequest.execute() as? [FlagEntities]
        }
        
        if let wrapFetchResults = fetchResults {
            if wrapFetchResults.count > 0 {
                return wrapFetchResults.first
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func setThreeNumber(){
        setThree = Set<Int>()
        setThree.insert(Int.random(in: 0..<flagQuiz.count))
        
        while setThree.count != 3 {
            setThree.insert(Int.random(in: 0..<flagQuiz.count))
        }
        
    }
    
    func continueGame() {
        isfirstTap = true
        roundCount += 1
        if timerCount <= 0 {
            roundCount = roundCount - 1
            showingReset = true
            opacityAmount = 0.5
            gameLogic()
        } else {
            showingReset = false
            gameLogic()
            scoreTitle = ""
            opacityAmount = 2
        }
    }
    
    func restartGame() {
        isfirstTap = true
        playerScore = 0
        correctAnswer = Int.random(in: 0...2)
        gameLogic()
        timerCount = timerDefault
        scoreTitle = "  "
        roundCount = 1
        opacityAmount = 2
    }
    
    func gameLogic() {
        setThreeNumber()
        arrayThree = Array(setThree)
        a = arrayThree[0]
        b = arrayThree[1]
        c = arrayThree[2]
        correctAnswer = Int.random(in: 0...2)
        
        
        
        if correctAnswer == 0 {
            correctAnswer = a
        } else if correctAnswer == 1 {
            correctAnswer = b
        } else if correctAnswer == 2 {
            correctAnswer = c
        }
        
//        print(arrayThree)
//        print("a=\(a) b=\(b) c=\(c)")
//        print(correctAnswer)
//        print("the correct is"+String(correctAnswer))
    }
}




//
//
//struct QuizFlag_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

