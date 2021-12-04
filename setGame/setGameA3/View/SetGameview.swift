//
//  ContentView.swift
//  setGameA3
//
//  Created by Sahil Sahu on 02/05/21.
//

import SwiftUI

struct setGameView: View {
    //MARK: Variable declarations
    @ObservedObject var viewModel: SetViewModel
    
    var temp: Bool = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100))]
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if(viewModel.cardsOnScreen.count>0){
                //MARK: Scroll View
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(viewModel.cardsOnScreen){ card in
                            cardView(viewModel: viewModel, card: card)
                                .aspectRatio(2/3, contentMode: .fill)
                                .onTapGesture {
                                    withAnimation(Animation.easeIn){
                                    viewModel.choose(card: card)
                                }
                                }
                        }
                    }
                }
                
                //MARK: Bottom bar
                HStack{
                   
                    Button(action: {
                        withAnimation(Animation.easeInOut) {
                            viewModel.newGame()
                        }
                    }) {Text("New Game")}
                    Spacer()
                    
                    Text("Score: \(viewModel.score)").font(.headline)
                   
                    Spacer()
                    Button(action: {
                    viewModel.addNewCard()
                }) {Text("Draw Card")}
                   
                }.padding()
                }
                else{
                    Text("Game over").font(.title).padding()
                    Text("Score: \(viewModel.score)").font(.body).padding()
                    Button(action: {
                        withAnimation(Animation.easeInOut) {
                            viewModel.newGame()
                        }
                    }) {Text("New Game")}
                    .padding()
                    Spacer()
                }
            }
            .navigationTitle("Set Game")
        }
    }
}


    
    
    struct cardView: View {
        
        //MARK: Variable declarations
        var viewModel: SetViewModel
        var card: Set_Game.Card
        let shape = RoundedRectangle(cornerRadius: 10)
        let randomx: Array<CGFloat> = [-400,400]
        let randomy: Array<CGFloat> = [-400,400]
        
        
        var body: some View{
            GeometryReader { geometry in
                //MARK: Card creation
                if(!card.isMatched){
                            
                    ZStack{
                        
                        shape.fill(Color.white)
                        if(card.isSelected){
                            shape.stroke(lineWidth: 4).foregroundColor(Color.red)
                        }else{
                            shape.stroke().foregroundColor(card.color)
                        }
                            showContent(card: card, size: geometry.size)
                    }
                    .padding()
                    
                }
                
        }
    }
        
        @ViewBuilder
        private func showContent(card: Set_Game.Card, size: CGSize) -> some View{
            let a = size.height
            let b = size.width
            let c = min(a,b) * 0.4
            
            if(card.noOfShapes > 1){
            VStack{
                ForEach(0..<card.noOfShapes){ index in
                    showShape(shape: card.shape, shading: card.shading, size: c*0.7, color: card.color)
                }
            }
            }
            else{
                VStack{
                    ForEach(0..<card.noOfShapes){ index in
                        showShape(shape: card.shape, shading: card.shading, size: c, color: card.color)
                    }
                }
            }
        }
        
        @ViewBuilder
    func showShape(shape: String, shading: Double, size: CGFloat, color: Color) -> some View{
        
        if(shape == "rectangle"){
            if(shading > 0){
                Rectangle()
                .fill(color)
                .frame(width: size, height: size)
                .opacity(shading)
                }
            
            else{
                    
                Rectangle()
                .stroke(card.color)
                .frame(width: size, height: size)
                
                }
        }
            
        
        else if(card.shape == "oval"){
            
            if(shading > 0){
            Ellipse()
            .fill(color)
            .frame(width: size, height: size)
            .opacity(shading)
                    
                
                
            }
            else{
            Ellipse()
            .stroke(color)
                .frame(width: size, height: size)
                    
            }
        }
        
        else{
            if(shading > 0){
                Diamond()
                    
                .fill(color)
                .frame(width: size, height: size)
                .opacity(shading)
                    
            
            }
            else{
                
            Diamond()
                
            .stroke(color)
            .frame(width: size, height: size)
                
            }
        }
        
        
    }
    }
        
        
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        setGameView(viewModel: SetViewModel())
    }
}
