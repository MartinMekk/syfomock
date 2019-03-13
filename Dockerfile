FROM node

RUN npm install elm http-server uglify-js

COPY . .

RUN /node_modules/elm/bin/elm make src/Main.elm --output elm.js --optimize
RUN /node_modules/uglify-js/bin/uglifyjs elm.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' --output=elm.js
RUN /node_modules/uglify-js/bin/uglifyjs elm.js --mangle --output=elm.js

ENTRYPOINT ["/node_modules/http-server/bin/http-server"]
