/**
 * Created by keipa on 2/6/2017.
 */

// Реализуйте на ECMAScript 2015 алгоритм сжатия информации по Хаффману


var codes = {};
var text = 'missisipi';

function freq(text) {
    var count = {};
    text.split('').forEach(s = > {
        count[s] ? count[s]++ : count[s] = 1; // if has symbol -> +1 else add symbol
})
    return count;
}

function sortFreq(dict) {
    var items = Object.keys(dict).map(key = > {return [dict[key], key];
})
    return items.sort(comparator);
}

function comparator(first, second) {
    return first[0] - second[0];
}

function buildTree(sort_lst) {
    if (sort_lst.length == 1) return sort_lst[0][1];
    else {
        comb_wt = sort_lst[0][0] + sort_lst[1][0];
        comb_node = [sort_lst[0][1], sort_lst[1][1]];
        sort_lst = sort_lst.slice(2);
        sort_lst.unshift([comb_wt, comb_node]);
        sort_lst.sort(comparator);
        return (buildTree(sort_lst));
    }
}

function assign_codes(node, cod) {
    cod = cod || "";
    if (typeof node === typeof cod) {
        codes[node] = cod;

    }
    else {
        assign_codes(node[0], cod + "0");
        assign_codes(node[1], cod + "1");
    }
}

function encode(str, encoded_str = "") {
    Array.from(str).forEach(v = > {encoded_str += codes[v]
})
    return encoded_str;
}

function decode(tree, encoded_str) {
    var decoded_str = "", node = tree;
    Array.from(encoded_str).forEach(i = > {
        i == "0" ? node = node[0] : node = node[1];
    if (typeof node === typeof "") {
        decoded_str += node;
        node = tree;
    }
})
    return decoded_str;
}


console.log("start code: " + text);
f = freq(text);
console.log(f);
s = sortFreq(f);
console.log(s);
tree = buildTree(s);
console.log(tree);
assign_codes(tree);
console.log(codes);
console.log("final code:" + encode(text));
console.log("decode code:" + decode(tree, encode(text)));


