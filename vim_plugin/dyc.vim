" press command [:so %] to load this file
" press [pr] to run python script below
"
"something else....
"
nnoremap pr :python Exampler().printWhereYouAre()<CR>

python << theNameYouNamed
import random
import vim
class Exampler:
    def __init__(self):
        self.currentX = 0
        self.currentY = 0
    
    def printWhereYouAre(self):
        x = vim.current.window.cursor[0]
        y = vim.current.window.cursor[1]
        self.currentX = x
        self.currentY = y
        print "I'm at the %s, %s"%(x,y)
    
    def addTheRandomNumInLineEnd(self):
        vim.current.buffer[self.currentX - 1] += random.randint(0,100)
theNameYouNamed