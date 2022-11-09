import UIKit

class Assignment {
    
    var result: [Int] = []
    
    func fibonacci(n: Int) -> [Int] {
        
        switch n {
        case ...0:
            return result
        case 1:
            result.append(0)
            return result
        
        default:
            result.append(0)
            result.append(1)
            let range = (n - 2)
            if range > 0 {
                for index in 1...range {
                    let newElement = result[index] + result[index - 1]
                    result.append(newElement)
                }
            }
            return result
        }

    }
}

let assignment = Assignment()

let result = assignment.fibonacci(n: 10)

print(result)
