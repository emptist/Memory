//
//  Grid.swift
//  Memory
//
//  Created by jk on 2020/6/4.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

/// Grid of items, with automatic sizing and positioning. The manual defined init func is not needed. However, if it's used then the wrapper @escaping must be used
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private(set) var items: Array<Item>
    private(set) var makeViewFor: (Item) -> ItemView
    
    ///  Note:  @escaping is needed here for swift to detect memory cycle
    
//    init(_ items:[Item], content viewForItem: @escaping (Item) -> ItemView) {
//        self.items = items
//        self.viewForItem = viewForItem
//    }

    
    var body: some View {
        GeometryReader { geometry in
            self.viewBody(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func viewBody(for layout: GridLayout) -> some View {
        ForEach(items) { subview in
            self.viewBody(for: subview, in: layout)
        }
    }
    
    private func viewBody(for subview: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: subview)! // an index should always be there
        return self.makeViewFor(subview)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
}


//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
