def fullJustify( words, maxWidth):
        words = [item for item in words if type(item) is str]
        length_list = list(map(len,words))        
        idx = 0
        ret = []
        while(idx < len(words)):
            s = idx
            while(idx < len(words) and (sum(length_list[s:idx+1])+idx-s) <= maxWidth):
                idx += 1
            
            tmp = words[s]
            if type(tmp) is str:
              if idx-s ==1:               # if there is only one word
                  tmp += ' '* (maxWidth-len(tmp))
              elif idx == len(words):     # if this is the last element
                  tmp = ' '.join(words[s:idx])
                  tmp += ' '* (maxWidth-len(tmp))
              else:         # normal case
                  minLength = (idx-s-1) + sum(length_list[s:idx])     # minimum length is number of space + total length of strings
                  numExSpace = maxWidth - minLength
                  unitSpace = numExSpace//(idx-s-1)
                  extraSpace = numExSpace % (idx-s-1)
                  tmp = words[s]
            for i in range(s+1, idx):
                    # add space
                    extra = 1 if i-s <= extraSpace else 0
                    space = ' '*(1+unitSpace+extra)
                    tmp += space
                    # add next word
                    tmp += words[i]
            
            
            ret.append(tmp)
        return ret

words = [11, "This", "is", "an", "example", "of", "text"]
maxWidth = 11
words.remove(11)
fullJustify(words, maxWidth)
