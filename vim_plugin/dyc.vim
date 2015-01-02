" press command [:so %] to load this file
" press [pr] to run python script below
"
"something else....
"
if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif


nnoremap pr :python Exampler().printWhereYouAre()<CR>

if !exists("g:reddit_apicall_timeout")
    let g:reddit_apicall_timeout=40
endif

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
        del vim.current.buffer[:]
        vim.current.buffer.append("hehe")
        vim.command(":vsp")

        TIMEOUT = vim.eval("g:reddit_apicall_timeout")
        print TIMEOUT
    
    def addTheRandomNumInLineEnd(self):
        vim.current.buffer[self.currentX - 1] += random.randint(0,100)
theNameYouNamed
