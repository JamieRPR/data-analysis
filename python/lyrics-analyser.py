class TextFrequency():
    def __init__(self, file_name):
        self.file_name = file_name
        self.text = []
        self.getText()

    def getText(self):
        file = open(self.file_name)
        self.text = file.read()
        file.close()


    def letterFreq(self):
        freq = {}
        text = self.text

        for letters in text:
            if letters in freq:
                freq[letters] += 1
            else:
                freq[letters] = 1

        return freq
        # return {key : self.text.count(key) for key in self.text}

    def wordFreq(self):
        freq = {}
        text = self.text.split()

        for word in text:
            if word in freq:
                freq[word] += 1
            else:
                freq[word] = 1

        return freq

    def toLower(self):
        self.text = self.text.lower()


class HistogramPrinter(TextFrequency,):
    def __init__(self, file_name):
        TextFrequency.__init__(self, file_name)

    def printLetterHist(self):
        freq = self.letterFreq()

        for letters in freq:
            print(letters + (" *" * freq[letters]))

    def printWordHist(self):
        freq = self.wordFreq()

        for letters in freq:
            print(letters + (" *" * freq[letters]))

# myTextFrequency = TextFrequency("lyrics.txt")
# letterFreq = myTextFrequency.letterFreq()

# for letter in letterFreq:
#     print(letter, letterFreq[letter])


myHistogram = HistogramPrinter("lyrics.txt")
myHistogram.toLower()
myHistogram.printWordHist()
myHistogram.printLetterHist()
