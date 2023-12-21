import SwiftUI

struct Social: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack {
                    
                    HStack{
                        NavigationLink(destination: Search()) {
                            
                            HStack {
                                
                                
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 24))
                            }
                            .padding(.trailing, 10.0)
                        }
                        NavigationLink(destination: Notifications()) {
                            
                            HStack {
                                
                                
                                Spacer()
                                Image(systemName: "bell")
                                    .font(.system(size: 24))
                            }
                            .padding(.trailing, 10.0)
                        }
                    }
                    
                
                    
                    CMPreviewBox()
                        .padding(.top, 11.0)
                    Divider()
                    
                    
                    Events()
               
                    
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .padding(.bottom, 20)
            }
            
        }
    }
}



//struct Social_Previews: PreviewProvider {
//    static var previews: some View {
//        Social()
//    }
//}
