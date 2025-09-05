Multi Stage Docker Build
The main purpose of choosing a golang based applciation to demostrate this example is golang is a statically-typed programming language that does not require a runtime in the traditional sense. Unlike dynamically-typed languages like Python, Ruby, and JavaScript, which rely on a runtime environment to execute their code, Go compiles directly to machine code, which can then be executed directly by the operating system.

So the real advantage of multi stage docker build and distro less images can be understand with a drastic decrease in the Image size

ठीक है, मैं तुम्हें ये पूरा Dockerfile, Multi-Stage Build, Go language का फायदा, और तुम्हारा calculator.go प्रोग्राम — सब कुछ अपनी आसान भाषा में समझा देता हूँ।  

---

## 1️⃣ Multi-Stage Docker Build क्या है?  
Multi-Stage Build का मतलब है कि हम Docker image को कई stages में बनाते हैं।  
- पहले stage में हम **build** करते हैं (code compile, dependencies install वगैरह)  
- दूसरे stage में हम सिर्फ **final output** (binary) रखते हैं, बाकी बेकार की चीजें हटा देते हैं।  

इससे image का size बहुत छोटा हो जाता है और production में सिर्फ जरूरी files जाती हैं।  

---

## 2️⃣ तुम्हारा Dockerfile Step-by-Step

### **Stage 1: Build Stage**
```dockerfile
FROM ubuntu AS build
```
- Base image: Ubuntu  
- `AS build` मतलब इस stage का नाम `build` रखा, ताकि बाद में reference कर सकें।

```dockerfile
RUN apt-get update && apt-get install -y golang-go
```
- Ubuntu में Go language install कर रहे हैं ताकि code compile हो सके।

```dockerfile
ENV GO111MODULE=off
```
- Go modules को disable कर रहे हैं (पुराने style में build करने के लिए)।

```dockerfile
COPY . .
```
- Current directory का सारा code container में copy कर रहे हैं।

```dockerfile
RUN CGO_ENABLED=0 go build -o /app .
```
- Go code को compile करके `/app` नाम का binary बना रहे हैं।  
- `CGO_ENABLED=0` का मतलब है कि हम pure Go binary बना रहे हैं, जिसमें C dependencies नहीं होंगी — इससे portability और compatibility बढ़ती है।

---

### **Stage 2: Final Stage**
```dockerfile
FROM scratch
```
- `scratch` एक completely empty image है — इसमें कुछ भी नहीं होता।  
- इसका फायदा: final image बहुत छोटी होती है (कुछ MB या KB में)।

```dockerfile
COPY --from=build /app /app
```
- पहले stage (`build`) से compiled binary `/app` को copy कर रहे हैं।

```dockerfile
ENTRYPOINT ["/app"]
```
- Container start होते ही `/app` binary run होगी।

---

## 3️⃣ Build और Run कैसे करेंगे?

```bash
# Build image
docker build -t go-calculator .

# Run container
docker run -it go-calculator
```
- `-it` का मतलब है interactive mode, ताकि तुम calculator में input दे सको।

---

## 4️⃣ Go Language क्यों चुना?  
- Go एक **statically typed** language है — compile होते समय ही machine code बन जाता है।  
- Python, JavaScript जैसी languages को runtime चाहिए, लेकिन Go को नहीं।  
- इसका मतलब है कि हम सिर्फ binary file को run कर सकते हैं, बिना किसी extra dependency के।  
- Multi-stage build + Go = super small image size (कभी-कभी 10MB से भी कम)।

---

## 5️⃣ calculator.go Program Explanation (अपनी भाषा में)

ये प्रोग्राम एक simple calculator है जो user से input लेता है और calculation करता है।

### Flow:
1. **Welcome Message**  
   ```go
   fmt.Println("Hi Abhishek.Veeramalla, I am a calculator app ....")
   ```
   - Program start होते ही ये message print करता है।

2. **Infinite Loop**  
   ```go
   for {
       ...
   }
   ```
   - Calculator तब तक चलता रहेगा जब तक user `"exit"` नहीं लिखता।

3. **User Input लेना**  
   ```go
   reader := bufio.NewReader(os.Stdin)
   text, _ := reader.ReadString('\n')
   text = strings.TrimSpace(text)
   ```
   - User से एक line input लेता है और newline हटाता है।

4. **Exit Condition**  
   ```go
   if text == "exit" {
       break
   }
   ```
   - अगर user `"exit"` लिखे तो loop से बाहर निकल जाता है।

5. **Input को Split करना**  
   ```go
   parts := strings.Split(text, " ")
   ```
   - Example: `"2 + 3"` → `["2", "+", "3"]`  
   - अगर 3 parts नहीं हैं तो error message देता है।

6. **Operands को Integer में Convert करना**  
   ```go
   left, _ := strconv.Atoi(parts[0])
   right, _ := strconv.Atoi(parts[2])
   ```

7. **Operator Check और Calculation**  
   ```go
   switch parts[1] {
   case "+":
       result = left + right
   case "-":
       result = left - right
   case "*":
       result = left * right
   case "/":
       result = left / right
   default:
       fmt.Println("Invalid operator. Try again.")
   }
   ```

8. **Result Print करना**  
   ```go
   fmt.Printf("Result: %d\n", result)
   ```

---

## 6️⃣ Multi-Stage Build + Go का असली फायदा
- **Without Multi-Stage**: Image में compiler, dependencies, और source code सब होगा → size बड़ा होगा (200MB+)
- **With Multi-Stage**: Final image में सिर्फ compiled binary होगी → size बहुत छोटा (10-15MB)
- **Security**: कम files → कम attack surface
- **Performance**: Load और deploy जल्दी

---

अगर तुम चाहो तो मैं तुम्हें इसका **image size comparison** और **Docker build का live demo** भी दिखा सकता हूँ, जिससे फर्क साफ दिखेगा।  
क्या मैं वो भी बना दूँ?
बढ़िया 👍  
तो चलो अब मैं तुम्हें **Multi-Stage Build + Go** का **live size comparison** और build/run process का पूरा practical तरीका समझा देता हूँ, ताकि तुम्हें फर्क साफ दिखे।  

---

## 🛠 Step 1: Dockerfile (तुम्हारा वाला ही)
```dockerfile
###########################################
# BASE IMAGE
###########################################
FROM ubuntu AS build

RUN apt-get update && apt-get install -y golang-go

ENV GO111MODULE=off

COPY . .

RUN CGO_ENABLED=0 go build -o /app .

############################################
# FINAL IMAGE
############################################
FROM scratch

COPY --from=build /app /app

ENTRYPOINT ["/app"]
```

---

## 🏗 Step 2: Build Image
```bash
# Build the image
docker build -t go-calculator .
```
- `-t go-calculator` → image का नाम रखा  
- Multi-stage होने की वजह से final image में सिर्फ binary जाएगी

---

## 🚀 Step 3: Run Container
```bash
docker run -it go-calculator
```
- `-it` → interactive mode, ताकि तुम calculator में input दे सको  
- अब तुम `2 + 3` या `5 * 6` जैसे commands दे सकते हो  
- `exit` लिखते ही program बंद हो जाएगा

---

## 📏 Step 4: Size Comparison
अगर हम **multi-stage** न करें और सीधे Ubuntu में build करके run करें, तो:
```bash
docker build -t go-calculator-big -f Dockerfile.single .
docker images
```
- Single-stage image: ~200MB+  
- Multi-stage image: ~10-15MB  
यानी size में **10x से ज्यादा कमी**।

---

## 🔍 क्यों फर्क पड़ता है?
- **छोटा size** → जल्दी pull/push होता है  
- **कम dependencies** → security risk कम  
- **Go का फायदा** → runtime की जरूरत नहीं, सिर्फ binary run होती है  
- **scratch image** → zero extra files, सिर्फ तुम्हारा app

---

## 🧮 cal.go Program Recap (अपनी भाषा में)
- User से input लेता है (`2 + 3`)  
- Space से split करता है → left operand, operator, right operand  
- Operator के हिसाब से calculation करता है  
- Result print करता है  
- `exit` लिखने पर बंद हो जाता है  

---

अगर तुम चाहो तो मैं तुम्हारे लिए **एक ही code से दो Dockerfile** बना सकता हूँ — एक single-stage और एक multi-stage — और फिर दोनों का size difference दिखा सकता हूँ, ताकि तुम्हें practically समझ आ जाए कि multi-stage कितना powerful है।  

क्या मैं वो बना दूँ?



