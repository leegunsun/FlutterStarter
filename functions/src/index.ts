/**
 * Firebase Functions 예제 코드
 *
 * 이 예제는 Firebase Functions v2를 사용하여 HTTP 요청, 클라우드 함수 호출,
 * 그리고 Firestore 문서 생성 이벤트에 반응하는 세 가지 함수를 보여줍니다.
 */

// Firebase Functions와 Firestore 트리거를 가져옵니다.
const {onRequest,onCall,HttpsError} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

admin.initializeApp();

// 1. HTTP 요청을 처리하는 onRequest 함수 예제
exports.helloWorld = onRequest((request, response) => {
  logger.info("helloWorld 함수에 요청이 도착했습니다.", {
    structuredData: true,
  });

  // 요청 쿼리에서 name 파라미터를 가져옵니다.
  const name = request.query.name || "Firebase";

  // 응답으로 환영 메시지를 전송합니다.
  response.send(`안녕하세요, ${name}님! Firebase Functions에 오신 것을 환영합니다.`);
});

// 2. 클라이언트에서 직접 호출할 수 있는 onCall 함수 예제
exports.addNumbers = onCall((data, context) => {
  // data 객체에서 두 개의 숫자 값을 받아옵니다.
  const {a, b} = data;

  // 숫자 타입 검증
  if (typeof a !== "number" || typeof b !== "number") {
    throw new HttpsError("invalid-argument","함수는 두 개의 숫자(a, b)를 인자로 호출되어야 합니다.");
  }

  const result = a + b;
  logger.info(`addNumbers 함수: ${a} + ${b} = ${result}`, {structuredData: true,});

  // 결과를 반환합니다.
  return {result};
});

// 3. Firestore에서 "messages" 컬렉션에 문서가 생성될 때 트리거되는 함수 예제
exports.onMessageCreate = onDocumentCreated("messages/{docId}", (event) => {
  // 생성된 문서의 데이터를 가져옵니다.
  const newMessage = event.data.data();

  logger.info(`새로운 메시지 문서 생성됨 (ID: ${event.params.docId}): ${JSON.stringify(newMessage)}`,{structuredData: true});

  // 추가 처리가 필요하다면 이곳에 작성할 수 있습니다.
});

// HTTP 요청을 통해 FCM 푸시 알림을 전송하는 함수
exports.sendPushNotification = onRequest(async (req, res) => {
  logger.info("sendPushNotification 함수 호출됨.", {structuredData: true});

  // POST 방식이 아니면 허용하지 않음
  if (req.method !== "POST") {
    res.status(405).send("Method Not Allowed. POST 요청만 지원합니다.");
    return;
  }

  // 클라이언트에서 전달받은 FCM 토큰, 제목, 본문, 그리고 선택적인 데이터 추출
  const {token, title, body, data} = req.body;

  // 필수 파라미터 검증: 토큰, 제목, 본문은 반드시 필요합니다.
  if (!token || !title || !body) {
    res
      .status(400)
      .send(
        "필수 파라미터가 누락되었습니다. 'token', 'title', 'body'가 필요합니다."
      );
    return;
  }

  // FCM 메시지 페이로드 구성
  const message = {
    token: token,
    notification: {
      title: title,
      body: body,
    },
    // 추가적인 커스텀 데이터가 있다면 전달 (문자열 형태여야 합니다)
    data: data || {},
  };

  try {
    // Firebase Admin SDK의 messaging 서비스로 FCM 메시지 전송
    const response = await admin.messaging().send(message);
    logger.info(`메시지 전송 성공. Message ID: ${response}`, {
      structuredData: true,
    });
    res.status(200).send({messageId: response});
  } catch (error) {
    logger.error("FCM 메시지 전송 중 오류 발생:", error);
    res.status(500).send({error: error.message});
  }
});
