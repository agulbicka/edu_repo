'This is my example python code'
'Learning git'

'turn Q into Phred+33 ASCII-encoded quality'
def Qto_Phred33(Q):
    return chr(Q+33)

'turn Phred+33 ASCII-encoded quality into Q'
def phred33toQ(qual):
    return ord(qual)-33
