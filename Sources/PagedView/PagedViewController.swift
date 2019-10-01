import SwiftUI
import UIKit

struct PagedViewController<Element: Identifiable, Content: View>: UIViewControllerRepresentable {
    
    let transitionStyle: UIPageViewController.TransitionStyle
    let navigationOrientation: UIPageViewController.NavigationOrientation
    let options: [UIPageViewController.OptionsKey: Any]?
    
    let objects: [Element]
    let config: (Element) -> Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PagedViewController>) -> UIPageViewController {
        let vc = UIPageViewController(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options)
        vc.dataSource = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: UIViewControllerRepresentableContext<PagedViewController>) {
        uiViewController.setViewControllers([context.coordinator.firstViewController()], direction: .forward, animated: false, completion: nil)
    }
    
    func makeCoordinator() -> Coordinator<Element, Content> {
        return Coordinator(objects: objects, config: config)
    }
    
    final class Coordinator<Element, Content: View>: NSObject, UIPageViewControllerDataSource where Element: Identifiable {
        private let objects: [Element]
        private let config: (Element) -> Content
        
        init(objects: [Element], config: @escaping (Element) -> Content) {
            assert(!objects.isEmpty, "Objects need to have at least one Element")
            self.objects = objects
            self.config = config
        }
        
        func firstViewController() -> UIViewController {
            return ContentViewController(element: objects[0], rootView: config(objects[0]))
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let contentVC = viewController as? ContentViewController<Element, Content>,
                let index = objects.firstIndex(of: contentVC.element),
                index > 0 else { return nil }
            return ContentViewController(element: objects[index - 1], rootView: config(objects[index - 1]))
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let contentVC = viewController as? ContentViewController<Element, Content>,
                let index = objects.firstIndex(of: contentVC.element),
                index < objects.count - 1 else { return nil }
            return ContentViewController(element: objects[index + 1], rootView: config(objects[index + 1]))
        }
    }
    
    private final class ContentViewController<Element: Identifiable, Content: View>: UIHostingController<Content> {
        
        let element: Element
        
        init(element: Element, rootView: Content) {
            self.element = element
            super.init(rootView: rootView)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
    }
}
