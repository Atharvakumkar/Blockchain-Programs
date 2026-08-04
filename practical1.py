
import hashlib
import time

class Block:
    def __init__(self, index, timestamp, data, prior_hash=0):
        self.index = index
        self.timestamp = timestamp
        self.data = data
        self.prior_hash = prior_hash
        self.hash = ''

    def create_hash(self):
        blockString = f"{self.index}{self.timestamp}{self.data}{self.prior_hash}"
        return hashlib.sha256(blockString.encode()).hexdigest()


Data1 = 'Transactiona1: Acc. A -> Acc. B = Rs. 10'
Block1 = Block(1, time.strftime("%H:%M:%S", time.localtime()), Data1, 0)
Block1.hash = Block1.create_hash()

print('Block index:', Block1.index, '\n',
      'Block Timestamp:', Block1.timestamp, '\n',
      'Block Data:', Block1.data, '\n',
      'Block Previous hash:', Block1.prior_hash
      )


class Blockchain:
    def __init__(self):
        self.chain = [self.create_genesis()]

    def create_genesis(self):
        block = Block(1, time.strftime("%H:%M:%S", time.localtime()), '', 0)
        block.hash = block.create_hash()
        return block

    def getLastBlock(self):
        return self.chain[-1]

    def addBlock(self, newBlock):
        newBlock.prior_hash = self.getLastBlock().hash
        newBlock.hash = newBlock.create_hash()
        self.chain.append(newBlock)

    def CheckBlockChain(self):
        for i in range(1, len(self.chain)):
            current_block = self.chain[i]
            previous_block = self.chain[i - 1]

            if current_block.hash != current_block.create_hash():
                return False

            if current_block.prior_hash != previous_block.hash:
                return False

        return True

    def display_blockchain(self):
        for i in range(len(self.chain)):
            print('Block:', self.chain[i].index)
            print('Data:', self.chain[i].data)
            print('Hash:', self.chain[i].hash)
            print('Block prior Hash:', self.chain[i].prior_hash)


Blockchain1 = Blockchain()

data1 = 'Tx1: Acc 1234 -> Acc 6789 = Rs.500'
t1 = time.strftime("%H:%M:%S", time.localtime())

block2 = Block(2, t1, data1)
Blockchain1.addBlock(block2)

Blockchain1.display_blockchain()

print("Blockchain Valid:", Blockchain1.CheckBlockChain())
