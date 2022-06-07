$(document).ready(function () {
    var att0 = $($($(".ui-form-list-btn")[0]).find("input[type='button']")[0]).attr("onclick")
    var att1 = $($($(".ui-form-list-btn")[0]).find("input[type='button']")[1]).attr("onclick")

    var attx = att0.replaceAll("javascript:", "")
    var att01 = "javascript:if(cariKontrolEt()){" + attx + "}";
    $($($(".ui-form-list-btn")[0]).find("input[type='button']")[0]).attr("onclick", att01)


    var atty = att1.replaceAll("javascript:", "")
    var att11 = "javascript:" + atty + " bakiyeGetir()"
    $($($(".ui-form-list-btn")[0]).find("input[type='button']")[1]).attr("onclick", att11)


    var e = document.getElementById("sepetim_total")
    var ss = e.children[e.children.length - 1]
    var dsonuc = document.createElement("div");
    dsonuc.setAttribute("id", "dsonuc");
    ss.appendChild(dsonuc);

})

function cariKontrolEt() {
    var ex = document.getElementById("company_name")
    var exv = ex.value
    console.log("cari seçildi")
    if (exv.length != 0) {
        console.log("hey")
        bakiyeGetir();
        return true
    } else {
        alert("Cari Seçmelisiniz")
        return false;
    }

}


function bakiyeGetir() {

    var e = document.getElementById("company_id")
    var cpid = e.value
    var q = wrk_query("select * from COMPANY_REMAINDER_MONEY where COMPANY_ID=" + cpid, "dsn2")
    var q2 = wrk_query("select * from COMPANY_REMAINDER where COMPANY_ID=" + cpid, "dsn2")
    console.log(q2)
    var tbl = document.createElement("table")
    var t = document.createElement("tbody");
    tbl.appendChild(t);
    var div = document.createElement("div");
    div.setAttribute("class", "ui-scroll ListContent");
    tbl.setAttribute("class", "ui-table-list ui-form")

    var thead = document.createElement("thead");
    var tr = document.createElement("tr");
    var td = document.createElement("th");
    td.setAttribute("colspan", "2");
    td.innerText = "Cari Bakiyesi";
    tr.appendChild(td);
    thead.appendChild(tr);
    tbl.appendChild(thead);

    tbl.appendChild(t);
    if (q.recordcount) {

        var tr = document.createElement("tr")
        var td = document.createElement("td")
        td.innerText = "Borç"
        tr.appendChild(td);
        var td = document.createElement("td")
        td.innerText = formatNumberB(q2.BORC[0], "TRY")
        tr.appendChild(td);
        t.appendChild(tr)

        var tr = document.createElement("tr")
        var td = document.createElement("td")
        td.innerText = "Alacak"
        tr.appendChild(td);
        var td = document.createElement("td")
        td.innerText = formatNumberB(q2.ALACAK[0], "TRY")
        tr.appendChild(td);
        t.appendChild(tr)
        var tr = document.createElement("tr")
        var td = document.createElement("td")
        td.innerText = "Bakiye"
        tr.appendChild(td);
        var td = document.createElement("td")
        var dss = parseFloat(q2.BAKIYE[0])
        if (dss < 0) {
            td.innerText = formatNumberB(dss * -1, "TRY") + "(A)"
        } else {
            td.innerText = formatNumberB(q2.BAKIYE[0], "TRY") + "(B)"
        }

        tr.appendChild(td);
        t.appendChild(tr)

        for (let i = 0; i < q.recordcount; i++) {
            var tr = document.createElement("tr")
            var td = document.createElement("td")
            tr.appendChild(td)
            var d = parseFloat(q.BAKIYE3[i])
            var d2 = parseFloat(q.BAKIYE3[i])
            if (d2 < 0) {
                d = d * -1
            }

            td.innerText = formatNumberB(d, q.OTHER_MONEY[i])

            if (d2 < 0) {
                td.innerText += " (A)"
            } else {
                td.innerText += " (B)"
            }
            t.appendChild(tr)
        }
    } else {
        var tr = document.createElement("tr");
        var td = document.createElement("td");
        td.setAttribute("colspan", "2");
        td.innerText = "Kayıt Bulunamadı !";
        tr.appendChild(td);
        t.appendChild(tr);
    }
    var e = document.getElementById("dsonuc")
    $(e).html("");
    div.appendChild(tbl);
    e.appendChild(div);

}

function formatNumberB(num, mon) {
    if (mon == "TL") {
        mon = "TRY"
    }

    var formatter = new Intl.NumberFormat(navigator.language, {
        style: 'currency',
        currency: mon,
    })
    return formatter.format(num);
}