#!/usr/bin/env node
'use strict';

const stripSpaces = str => {
    return str.replace(/[\ \t]/g,'');
};

const isBetween = (range, num) => {
    const begin = range[0];
    const end = range[1];
    return begin <= num && num < end;
};

const parseTimeTable = (timeTable) => {
    timeTable = stripSpaces(timeTable);
    const arr = [];
    timeTable.split('\n').forEach(lineStr => {
        if (lineStr !== '') {
            const line = {};
            lineStr.split(';').forEach((item, index, lineSplit) => {
                if (lineSplit.length === 2) {
                    if (index === 0) {
                        const ranges = [];
                        item.split(',').forEach(rangeStr => {
                            const range = [];
                            rangeStr.split('-').forEach(timeStr => {
                                timeStr !== '' && range.push(parseInt(timeStr, 10));
                            });
                            if (range.length === 2) {
                                let begin = range[0];
                                let end = range[1];
                                begin = parseInt(begin, 10);
                                end = parseInt(end, 10);
                                (Number.isInteger(begin) && Number.isInteger(end) && begin <= end)
                                    && ranges.push(range);
                            }
                        });
                        ranges.length !== 0 && (line.ranges = ranges);
                    } else {
                        item !== '' && (line.symbol = item);
                    }
                }
            });
            (line.ranges && line.symbol) && arr.push(line);
        }
    });
    return arr;
};

const getTip = (timeTable) => {
    const hour = new Date().getHours();
    // const hour = 23; // for test
    const timeTableObj = parseTimeTable(timeTable);
    for (let i = 0; i < timeTableObj.length; i++) {
        const line = timeTableObj[i];
        const ranges = line.ranges;
        const symbol = line.symbol;
        for (let i = 0; i < ranges.length; i++) {
            const range = ranges[i];
            if(isBetween(range, hour)) {
                return symbol;

            }
        }
    }
};
const run = () => {
    if (process.argv.length >= 3) {
        const tip = getTip(process.argv[2]);
        if (tip) {
            process.stdout.write(tip);
        }
        process.exit(0);
    }
    process.stderr.write('arg is needed.');
    process.exit(1);
};

run();