//
//  MainMenuView.swift
//  MADMeditaion
//
//  Created by Студент on 27.01.2022.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack(){
            Color(#colorLiteral(red: 0.1453521252, green: 0.2015509009, blue: 0.205006659, alpha: 1))
            
            VStack(){
                HeaderView()
                
                ContentView()
                    .padding(.top, 27)
                
                Spacer()
                
                BottomNavigatonView()
                    .padding(.bottom, 27)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

struct HeaderView: View{
    var body: some View{
            HStack(){
                Image("Hamburger")
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 49)
                
                Spacer()
                
                Image("Photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(100)
                    .frame(width: 36, height: 36)
            }
            .padding(.top, 63)
            .padding(.horizontal, 25)
        }
}

struct ContentView: View{
    @State var miniCards: [MiniCard] = []
    @State var modelToGet: GetMiniCardModel?
    
    @State var bigCards: [BigCardModel] = []
    @State var modelToGetBigCards: GetBigCardModel?
        
    var body: some View{
        VStack(){
            Text("С возвращением, Эмиль !")
                .font(.custom("Alegreya-Medium.ttf", size: 30))
                .foregroundColor(.white)
            
            Text("Каким ты себя ощущаешь сегодня ?")
                .font(.custom("Alegreya-Medium", size: 22))
                .foregroundColor(Color(#colorLiteral(red: 0.7462719083, green: 0.7613148689, blue: 0.7609142661, alpha: 1)))
                .padding(.top, 12)
                
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 17){
                    ForEach(miniCards){ item in
                        MiniCardView(miniCardModel: item)
                    }
                }
            }
            .padding(.leading, 25)
            .onAppear(){
                Api().getMiniCards { (modelToGet) in
                    self.modelToGet = modelToGet
                    self.miniCards = OrderMiniCard(miniCards: modelToGet.data)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 26){
                    ForEach(bigCards, id: \.id){ item in
                        BigCardView(bigCardModel: item)
                    }
                }
            }
            .frame(height: 390)
             .padding(.top, 22)
             .onAppear(){
                    Api().getBigCards { ( modelToGetBigCards ) in
                        self.modelToGetBigCards = modelToGetBigCards
                        self.bigCards = modelToGetBigCards.data
                    }
                }
            
        }
    }
}

func OrderMiniCard(miniCards: [MiniCard]) -> [MiniCard]{
    var mutadedMiniCards = miniCards
    var buff: MiniCard = MiniCard
    
    for i in 0...miniCards.count {
        for j in 0...miniCards.count {
            if(miniCards[i].position > miniCards[j].position){
                buff = mutadedMiniCards[i]
                mutadedMiniCards[i] = mutadedMiniCards[j]
                mutadedMiniCards[j] = buff
            }
        }
    }
    
    return mutadedMiniCards
}


struct MiniCardView: View{
    var miniCardModel: MiniCard
    
    var img: Image
    
    init(miniCardModel: MiniCard){
        self.miniCardModel = miniCardModel
        
        let url = URL(string: miniCardModel.image)!
        let dataImg = try! Data(contentsOf: url)
        let uiImg  =  UIImage(data: dataImg)!
        img = Image(uiImage: uiImg)
    }
    
    var body: some View{
        Button(action: {}){
            ZStack(){
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.9118606448, green: 0.921949327, blue: 0.9216032624, alpha: 1)))
                    .frame(width: 62, height: 65)
                    .cornerRadius(20)
                
                img
            }
            
            Text(miniCardModel.title)
                .font(.custom("Alegreya-Regular", size: 12))
                .foregroundColor(Color(#colorLiteral(red: 0.9118606448, green: 0.921949327, blue: 0.9216032624, alpha: 1)))
        }
            .frame(width: 63, height: 84)
            
    }
}

struct BigCardView: View{
    var bigCardModel: BigCardModel
    var img: Image
    
    init(bigCardModel: BigCardModel){
        let url = URL(string: bigCardModel.image)!
        let dataImg = try! Data(contentsOf: url)
        let uiImg  =  UIImage(data: dataImg)!
        img = Image(uiImage: uiImg)
        
        self.bigCardModel = bigCardModel
    }
    
    var body: some View{
        ZStack(){
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.9671772122, green: 0.9526218772, blue: 0.9396399856, alpha: 1)))
                .frame(width: 339, height: 179)
                .cornerRadius(15)
            
            VStack(alignment: .leading){
                Text(bigCardModel.title)
                    .font(.custom("Alegreya-Medium", size: 25))
                
                Text(bigCardModel.description)
                    .font(.custom("Alegreya-Medium", size: 15))
                    .frame(width: 190)
                    .lineLimit(2)
                    .padding(.top, -5)
                
                
                Button(action: {}){
                    ZStack(){
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0.149310112, green: 0.2054758966, blue: 0.2089295685, alpha: 1)))
                            .frame(width: 138, height: 39)
                            .cornerRadius(10)
                        
                        Text("подробнее")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 6)
                
            }
            .frame(maxWidth: 299, alignment: .leading)
            .background(img.frame(maxWidth: .infinity, alignment: .trailing))
        }
    }
}

struct BottomNavigatonView: View{
    var body: some View{
        HStack(spacing: 80){
            Button(action: {}){
                Image("Home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Button(action: {}){
                Image("Nav")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Button(action: {}){
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 226.77, height: 30)
    }
}

    
