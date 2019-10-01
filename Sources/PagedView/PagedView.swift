import SwiftUI
import UIKit

public struct PagedView<Element: Identifiable, Page: View>: View {
    
    let transitionStyle: UIPageViewController.TransitionStyle
    let navigationOrientation: UIPageViewController.NavigationOrientation
    let options: [UIPageViewController.OptionsKey: Any]?
    
    let objects: [Element]
    let config: (Element) -> Page
    
    public init(transitionStyle: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil,
                objects: [Element], config: @escaping (Element) -> Page) {
        self.transitionStyle = transitionStyle
        self.navigationOrientation = navigationOrientation
        self.options = options
        self.objects = objects
        self.config = config
    }
    
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
