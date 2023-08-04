// dangerfile.js

import { danger, schedule } from 'danger';

schedule(async () => {
  // PR başlığından "PR" kelimesini alın (büyük/küçük harf farkı olmaksızın)
  const prTitle = danger.github.pr.title.toLowerCase();

  // "PR" kelimesini içeren bir başlık varsa botu tetikle
  if (prTitle.includes('pr')) {
    console.log('Bot çalıştırılıyor...');
    // Burada botun yapması gereken işlemleri gerçekleştirin.
    // Örnek olarak uyarı veya yorum ekleyebilirsiniz.
  }
});
