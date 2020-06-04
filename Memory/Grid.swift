//
//  Grid.swift
//  Memory
//
//  Created by jk on 2020/6/4.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

/// Grid of items, with automatic sizing and positioning. The manual defined init func is not needed. However, if it's used then the wrapper @escaping must be used
struct Grid<Item,ItemView>: View where Item: Identifiable, ItemView: View {
    var items: Array<Item>
    var viewForItem: (Item) -> ItemView // MARK: - @escaping not needed here
    
//    init(_ items:[Item], content viewForItem: @escaping (Item) -> ItemView) {
//        self.items = items
//        self.viewForItem = viewForItem
//    }
//    
    var body: some View {
        GeometryReader(content: { geometry in
            self.viewBody(for: GridLayout(itemCount: self.items.count,in: geometry.size))
        })
    }
    
    func viewBody(for layout: GridLayout) -> some View {
        ForEach(items, content: { item in
            self.viewBody(for: item, in: layout)
        })
    }
    
    func viewBody(for item: Item,in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return self.viewForItem(item)
            .frame(width: layout.itemSize.width, height:layout.itemSize.height)
            .position(layout.location(ofItemAt: index!))
    }
    
}


//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
