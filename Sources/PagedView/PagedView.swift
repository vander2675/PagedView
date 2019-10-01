import SwiftUI
import UIKit

struct PagedView<Element: Identifiable, Page: View>: View {
    
    let transitionStyle: UIPageViewController.TransitionStyle
    let navigationOrientation: UIPageViewController.NavigationOrientation
    let options: [UIPageViewController.OptionsKey: Any]?
    
    let objects: [Element]
    let config: (Element) -> Page
    
    var body: some View {
        PagedViewController(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options, objects: objects, config: config)
    }
    
}

struct PagedView_Previews: PreviewProvider {
    static var previews: some View {
        PagedView(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil, objects: ["Text"]) { object in
            return Text(object)
        }
    }
}
