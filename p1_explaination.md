# Practical 1: Demonstrate Working of a Blockchain in Python

## Aim

To understand the basic working of a blockchain by implementing a simple blockchain in Python using SHA-256 hashing.

---

# Code Explanation

## 1. Import Libraries

```python
import hashlib
import time
```

### `hashlib`

- Imports Python's built-in cryptographic hashing library.
- Used to generate SHA-256 hashes for each block.
- SHA-256 ensures data integrity by producing a unique hash for every block.

### `time`

- Imports the time module.
- Used to generate timestamps indicating when each block is created.

---

## 2. Creating the Block Class

```python
class Block:
```

The `Block` class represents a single block in the blockchain.

Each block stores:

- Block Index
- Timestamp
- Transaction Data
- Previous Block Hash
- Current Block Hash

---

## 3. Constructor of Block Class

```python
def __init__(self, index, timestamp, data, prior_hash=0):
```

The constructor initializes a block whenever a new object is created.

### Variables

```python
self.index = index
```

Stores the block number.

Example:

```
Block 1
Block 2
Block 3
```

---

```python
self.timestamp = timestamp
```

Stores the creation time of the block.

Example:

```
10:45:32
```

---

```python
self.data = data
```

Stores the transaction details.

Example:

```
Acc A → Acc B = Rs.500
```

---

```python
self.prior_hash = prior_hash
```

Stores the hash of the previous block.

This creates the link between consecutive blocks.

---

```python
self.hash = ''
```

Creates an empty variable to store the current block's hash.

The hash is calculated later.

---

# 4. Hash Generation Function

```python
def create_hash(self):
```

This function generates a SHA-256 hash for the current block.

---

```python
blockString = f"{self.index}{self.timestamp}{self.data}{self.prior_hash}"
```

Combines all block information into a single string.

Example:

```
110:30:12Acc A→Acc B5000abcd123
```

---

```python
return hashlib.sha256(blockString.encode()).hexdigest()
```

### Step 1

Converts the string into bytes.

```python
blockString.encode()
```

---

### Step 2

Calculates the SHA-256 hash.

```python
hashlib.sha256(...)
```

---

### Step 3

Converts the hash into hexadecimal format.

```python
.hexdigest()
```

Example:

```
4f93bc90fd28d0e9d...
```

---

# 5. Creating the First Block

```python
Data1 = 'Transactiona1: Acc. A -> Acc. B = Rs. 10'
```

Stores transaction data.

---

```python
Block1 = Block(...)
```

Creates the first block.

Parameters:

- Block Number
- Timestamp
- Transaction Data
- Previous Hash

Since it is the first block, the previous hash is `0`.

---

```python
Block1.hash = Block1.create_hash()
```

Calculates and stores the hash of Block 1.

---

# 6. Displaying Block Information

```python
print(...)
```

Displays

- Block Number
- Timestamp
- Transaction Data
- Previous Hash

---

# 7. Creating the Blockchain Class

```python
class Blockchain:
```

This class manages the entire blockchain.

Instead of storing one block, it stores multiple blocks in a list.

---

# 8. Blockchain Constructor

```python
def __init__(self):
```

Executed automatically whenever a blockchain object is created.

---

```python
self.chain = [self.create_genesis()]
```

Creates a blockchain with a single Genesis Block.

---

# 9. Genesis Block

```python
def create_genesis(self):
```

Creates the first block of the blockchain.

A blockchain always begins with a Genesis Block.

---

```python
block = Block(...)
```

Creates the Genesis Block.

Values:

- Index = 1
- Timestamp = Current Time
- Data = Empty
- Previous Hash = 0

---

```python
block.hash = block.create_hash()
```

Generates the Genesis Block hash.

---

```python
return block
```

Returns the Genesis Block.

---

# 10. Getting the Latest Block

```python
def getLastBlock(self):
```

Returns the last block present in the blockchain.

---

```python
return self.chain[-1]
```

Python index `-1` refers to the last element in the list.

---

# 11. Adding a New Block

```python
def addBlock(self, newBlock):
```

Adds a new block to the blockchain.

---

```python
newBlock.prior_hash = self.getLastBlock().hash
```

Retrieves the hash of the last block and stores it as the previous hash of the new block.

This links both blocks together.

---

```python
newBlock.hash = newBlock.create_hash()
```

Calculates the hash of the new block.

---

```python
self.chain.append(newBlock)
```

Adds the new block to the blockchain.

---

# 12. Blockchain Validation

```python
def CheckBlockChain(self):
```

Checks whether the blockchain has been modified.

---

```python
for i in range(1, len(self.chain)):
```

Starts checking from the second block because the Genesis Block has no previous block.

---

```python
current_block = self.chain[i]
```

Gets the current block.

---

```python
previous_block = self.chain[i - 1]
```

Gets the previous block.

---

### Check 1

```python
if current_block.hash != current_block.create_hash():
```

Recalculates the current block's hash.

If the stored hash differs from the calculated hash, the block has been modified.

Returns:

```python
False
```

---

### Check 2

```python
if current_block.prior_hash != previous_block.hash:
```

Checks whether the previous hash stored in the current block matches the actual hash of the previous block.

If they do not match, the blockchain has been tampered with.

Returns:

```python
False
```

---

```python
return True
```

If every block passes both checks, the blockchain is valid.

---

# 13. Display Blockchain

```python
def display_blockchain(self):
```

Displays every block stored in the blockchain.

---

```python
for i in range(len(self.chain)):
```

Loops through all blocks.

---

Prints:

```python
print('Block:', self.chain[i].index)
```

Displays block number.

---

```python
print('Data:', self.chain[i].data)
```

Displays transaction details.

---

```python
print('Hash:', self.chain[i].hash)
```

Displays the block's hash.

---

```python
print('Block prior Hash:', self.chain[i].prior_hash)
```

Displays the hash of the previous block.

---

# 14. Creating a Blockchain Object

```python
Blockchain1 = Blockchain()
```

Creates a blockchain containing only the Genesis Block.

---

# 15. Creating a Transaction

```python
data1 = 'Tx1: Acc 1234 -> Acc 6789 = Rs.500'
```

Stores the transaction details.

---

```python
t1 = time.strftime("%H:%M:%S", time.localtime())
```

Stores the current timestamp.

---

# 16. Creating a New Block

```python
block2 = Block(2, t1, data1)
```

Creates Block 2.

Initially, its previous hash is empty.

---

# 17. Adding the Block

```python
Blockchain1.addBlock(block2)
```

Performs the following operations:

1. Retrieves the previous block's hash.
2. Stores it in Block 2.
3. Calculates Block 2's hash.
4. Adds Block 2 to the blockchain.

---

# 18. Display Blockchain

```python
Blockchain1.display_blockchain()
```

Displays all blocks along with:

- Block Number
- Transaction Data
- Previous Hash
- Current Hash

---

# 19. Validate Blockchain

```python
print("Blockchain Valid:", Blockchain1.CheckBlockChain())
```

Verifies that:

- Every block's stored hash is correct.
- Every block correctly stores the previous block's hash.

If both conditions are satisfied, the output is:

```
Blockchain Valid: True
```

---

# Program Flow

```
Start
   │
   ▼
Import hashlib and time
   │
   ▼
Create Block Class
   │
   ▼
Create Blockchain Class
   │
   ▼
Create Genesis Block
   │
   ▼
Create Transaction Block
   │
   ▼
Calculate SHA-256 Hash
   │
   ▼
Store Previous Block Hash
   │
   ▼
Add Block to Blockchain
   │
   ▼
Display Blockchain
   │
   ▼
Validate Blockchain
   │
   ▼
End
```

---

# Conclusion

This program demonstrates the basic working of a blockchain by implementing blocks connected through cryptographic hashes. Each block contains its own hash and the hash of the previous block, creating an immutable chain. The validation function verifies the integrity of the blockchain by checking both the block hashes and the links between consecutive blocks. This illustrates the core concepts of blockchain technology, including hashing, block linking, data integrity, and tamper detection.
