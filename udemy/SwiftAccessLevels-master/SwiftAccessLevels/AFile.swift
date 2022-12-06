//
//  AFile.swift
//  SwiftAccessLevels
//
//  Created by Angela Yu on 14/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class AClass {
    
    //Global variables, also called class properties.
    private var aPrivateProperty = "private property"
    
    fileprivate var aFilePrivateProperty = "fileprivate property"
    
    var anInternalProperty = "internal property"
    
    func methodA () {
        
        var aLocalVariable = "local variable"
        
        //Step 1. Try to print aLocalVariable Here - Possible
        //print("\(aLocalVariable) printed from methodA in AClass")
        
        //Step 3. Try to print aPrivateProperty Here
        // Will work, including on extensions. aPrivateProperty belongs to class scope
//        print("\(aPrivateProperty) printed from methodA in AClass")
        
        //Step 6. Try to print aFilePrivateProperty Here
        // Will work because aFilePrivateProperty is accessible to all classes into the file
//        print("\(aFilePrivateProperty) printed from methodA in AClass")
        
        //Step 9. Try to print anInternalProperty Here
        // Will work because anInternalProperty is accessible to all into the module trough AClass
        //print("\(aLocalVariable) printed from methodA in AClass")
    }
    
    func methodB () {
        
        //Step 2. Try to print aLocalVariable Here
        // Will not work because aLocalVariable has a local scope into methodA
        
        //Step 4. Try to print aPrivateProperty Here
        // Will work, including on extensions. aPrivateProperty belongs to class scope
//        print("\(aPrivateProperty) printed from methodB in AClass")
    }
    
}

class AnotherClassInTheSameFile {
    
    init() {
        
        //Step 5. Try to print aPrivateProperty Here
        // Will not work because aPrivateProperty is accessible only into AClass and it's extensions. It's private!
        
        //Step 7. Try to print aFilePrivateProperty Here
        // Will work because aFilePrivateProperty is accessible to all classes into the file
//        print("\(AClass().aFilePrivateProperty) printed from init in AnotherClassInTheSameFile")
    }
}

//extension AClass {
//
//    func extendedMethodA() {
//        print("\(aPrivateProperty) printed from extendedMethodA in the extension of AClass")
//    }
//
//}
