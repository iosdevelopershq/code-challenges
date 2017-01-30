import Foundation

/*
  This is perhaps a bit of a weird solution. :-)
  
  If gun is  || ||| ||||  | 
  
  then we glue two of these together to get:
  
    || ||| ||||  | || ||| ||||  |
  
  and then we try to find bullet as a substring:

                 | || ||| ||||

  This is a match, yay!

  However, this approach can produce false positives, as in this example:

    ||||      ||   ||||      ||
               |   ||||

  There is a matching substring but it's not a valid solution. To deal with
  this situation, we remove the parts of the string that match:
   
    ||||      |      ||

  If this is not identical to the original gun string, then the bullet did
  not come from the gun.
  
  It may sound slow but it's actually a very fast solution!
*/

let matthijsBulletMatchEntry = CodeChallengeEntry<BulletChallenge>(name: "matthijs") { (bullet, gun) in
  let gungun = gun + gun
  if let range = gungun.range(of: bullet) {
    let leftover = gungun.substring(to: range.lowerBound) + gungun.substring(from: range.upperBound)
    return (leftover == gun)
  }
  return false
}
