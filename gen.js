const fs = require("fs");
const path = require("path");

// Predefined keys to be used in all files
const keys = [
  "key1",
  "key2",
  "key3",
  "key4",
  "key5",
  "key6",
  "key7",
  "key8",
  "key9",
  "key10",
  "key11",
  "key12",
  "key13",
  "key14",
  "key15",
];

// Function to generate a random word (for values)
function generateRandomWord() {
  const chars = "abcdefghijklmnopqrstuvwxyz";
  const wordLength = Math.floor(Math.random() * 5) + 3; // Word length between 3 and 7
  let word = "";
  for (let i = 0; i < wordLength; i++) {
    word += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return word;
}

// Function to generate key-value pairs with random values
function generateKeyValuePairs(keys) {
  return keys.map((key) => `${key}=${generateRandomWord()}`).join("\n");
}

// Function to create a file with key-value pairs
function createFile(fileName) {
  const data = generateKeyValuePairs(keys);
  const filePath = path.join(__dirname, fileName);
  fs.writeFileSync(filePath, data, "utf8");
  console.log(`File ${fileName} created.`);
}

// Create 5 files with random values but same keys
for (let i = 1; i <= 5; i++) {
  const fileName = `file${i}.txt`;
  createFile(fileName);
}
