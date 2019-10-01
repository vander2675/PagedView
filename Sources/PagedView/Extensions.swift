import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Int? {
        return firstIndex { (innerElement) -> Bool in
            return innerElement.id == element.id
        }
    }
}

extension String: Identifiable {
    
    public var id: Int {
        return self.hashValue
    }
    
}
