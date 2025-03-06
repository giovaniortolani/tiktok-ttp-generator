const computeEffectiveTldPlusOne = require('computeEffectiveTldPlusOne');
const generateRandom = require('generateRandom');
const getCookieValues = require('getCookieValues');
const getEventData = require('getEventData');
const getRequestHeader = require('getRequestHeader');

const ttp = getCookieValues('_ttp');

if (data.returnExisting && ttp.length) return ttp[0];

const characters =
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
let result = '';
for (let i = 0; i < 27; i++) {
  const randomIndex = generateRandom(0, characters.length - 1);
  result += characters.charAt(randomIndex);
}
return result;
