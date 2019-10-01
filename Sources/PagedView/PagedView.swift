import SwiftUI
import UIKit

public struct PagedView<Element: Identifiable, Page: View>: View {
    
    public let transitionStyle: UIPageViewController.TransitionStyle
    public let navigationOrientation: UIPageViewController.NavigationOrientation
    public let options: [UIPageViewController.OptionsKey: Any]?
    
    public let objects: [Element]
    public let config: (Element) -> Page
    
    public var body: some View {
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
