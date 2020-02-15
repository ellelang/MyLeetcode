# Prints to standard output.
def wrapLines(line_length, words):
  # IMPLEMENTATION GOES HERE
  rowLen = 0
  row = []
  ans = []
  newitems = [item for item in words if type(item) is str]
  for word in newitems:
    if rowLen + len(word) + 1 - 1 < line_length:
       row.append(word)
       rowLen += len(word) + 1
    elif rowLen + len(word) + 1 - 1 == line_length:
        row.append(word)
        ans.append(row)
        row = []
        rowLen = 0
    else:
        ans.append(row)
        row = [word]
        rowLen = len(word) + 1
  if row != []:
    ans.append(row)
  
  for i, row in enumerate (ans):
    if i < len(ans)-1:
      count = len(row)
      if count > 1:
        length = sum(map(len,row))
        q, r = divmod(line_length - length, count - 1)
        
        newString = ""
        for j in range (count - 1):
          if j < r:
            newString += row[j] + " " * (q+1)
          else:
            newString += row[j] + " " * q
        newString += row[-1]
        ans[i] = newString
      else:
        ans[i] = row[0] + " " * (line_length - len(row[0]))
    else:
      ans[i] = " ".join(row)
      ans[i] = ans[i] + " " * (line_length - len(ans[i]))
                
  return ans          
line_length = 11
words = [11,  "This", "is", "an", "example", "of", "text"]
wrapLines(line_length, words)



new_items = [item for item in words if type(item) is str]
