import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var placeholder: String?
    
    var magnifyingIcon: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(Color(.lightGray))
    }
    
    var searchBar: some View {
        TextField(placeholder ?? "Search", text: $searchText)
            .textFieldStyle(PlainTextFieldStyle())
    }
    
    var cancelButton: some View {
        Button(
            action: { self.searchText = "" },
            label: { Text("Cancel") }
        )
        .transition(.move(edge: .trailing))
    }
    
    var backgroundShape: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color(.systemGray5))
    }
    
    var bottomDivider: some View {
        Divider().background(Color(.systemGray5))
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack {
                    magnifyingIcon
                    searchBar
                }
                .padding(8)
                .background(backgroundShape)
                
                if !searchText.isEmpty {
                    cancelButton
                }
            }
            .animation(.linear(duration: 0.16))
            .padding([.horizontal])
            .padding([.top, .bottom], 8)
            bottomDivider
        }
        .background(Color(.secondarySystemGroupedBackground))
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: Binding.constant(""))
    }
}
