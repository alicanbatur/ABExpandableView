# ABExpandableView

[![CI Status](http://img.shields.io/travis/alicanbatur/ABExpandableView.svg?style=flat)](https://travis-ci.org/alicanbatur/ABExpandableView)
[![Version](https://img.shields.io/cocoapods/v/ABExpandableView.svg?style=flat)](http://cocoapods.org/pods/ABExpandableView)
[![License](https://img.shields.io/cocoapods/l/ABExpandableView.svg?style=flat)](http://cocoapods.org/pods/ABExpandableView)
[![Platform](https://img.shields.io/cocoapods/p/ABExpandableView.svg?style=flat)](http://cocoapods.org/pods/ABExpandableView)


<a href="https://gfycat.com/RipeUnhappyDamselfly"><img src="https://thumbs.gfycat.com/RipeUnhappyDamselfly-size_restricted.gif"/></a>


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then run `ABExpandableView.xcworkspace` which is under `/Example` folder.

## Requirements
  - Swift 4
  - Xcode 9
   
## Installation

ABExpandableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ABExpandableView'
```
## Usage

First, import `ABExpandableView` to your project.

You should have 2 kinds of model objects to use this view that one of them should be section and the other one should be row.

Consider, Section and Row classes are your objects.

```swift
class Section: SectionItem {
    var identifier: String!
    var name: String!
    
    var expanded: Bool = true
    
    var rows: [RowItem] = [RowItem]()
    var rawRows: [RowItem] = [RowItem]() {
        didSet {
            rows = rawRows
        }
    }
    var selectedRows: [RowItem] = [RowItem]()
}

class Row: RowItem {
    var identifier: String!
    var name: String!
}

class MockDataProvider {
    
    class func createMockData() -> [SectionItem] {
        var array = [SectionItem]()
        
        let izmir = City()
        izmir.identifier = "35"
        izmir.name = "İzmir"
        let bornova = Town(identifier: "1", name: "Bornova")
        let urla = Town(identifier: "2", name: "Urla")
        let konak = Town(identifier: "3", name: "Konak")
        let izmirRawRows = [bornova, urla, konak]
        izmir.rawRows = izmirRawRows
        array.append(izmir)
        
        let istanbul = City()
        istanbul.identifier = "34"
        istanbul.name = "İstanbul"
        let kadikoy = Town(identifier: "4", name: "Kadıköy")
        let maltepe = Town(identifier: "5", name: "Maltepe")
        let beykoz = Town(identifier: "6", name: "Beykoz")
        let istanbulRawRows = [kadikoy, maltepe, beykoz]
        istanbul.rawRows = istanbulRawRows
        array.append(istanbul)
        
        return array
    }
    
}
```

After you create your models, you should open ABExpandableView with injecting those model array.

```swift
@IBAction func buttonTapped(_ sender: Any) {
        let cities = MockDataProvider.createMockData()
        let expandableSectionsViewModel = ExpandableSectionsViewModel(cities)
        let expandableSectionViewController = ExpandableSectionsViewController.newInstance(expandableSectionsViewModel)
        expandableSectionViewController.title = "Choose Town(s)"
        expandableSectionViewController.delegate = self
        self.navigationController?.pushViewController(expandableSectionViewController, animated: true)
    }
```

Here, let ABExpandableView handle the rest.

One last thing;
You can get selected items using the delegation;

```swift 
    func didSelectItems(_ items: [RowItem]) {
        let names = items.flatMap { $0.name }.joined(separator: ", ")
        // "Bornova, Kadıköy"
    }
```

## Author

alicanbatur, alicanbatur@gmail.com

## License

ABExpandableView is available under the MIT license. See the LICENSE file for more info.
