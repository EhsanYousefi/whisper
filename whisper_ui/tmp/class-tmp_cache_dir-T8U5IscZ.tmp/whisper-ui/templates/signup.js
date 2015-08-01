define('whisper-ui/templates/signup', ['exports'], function (exports) {

  'use strict';

  exports['default'] = Ember.HTMLBars.template((function() {
    return {
      meta: {
        "revision": "Ember@1.13.3",
        "loc": {
          "source": null,
          "start": {
            "line": 1,
            "column": 0
          },
          "end": {
            "line": 82,
            "column": 0
          }
        },
        "moduleName": "whisper-ui/templates/signup.hbs"
      },
      arity: 0,
      cachedFragment: null,
      hasRendered: false,
      buildFragment: function buildFragment(dom) {
        var el0 = dom.createDocumentFragment();
        var el1 = dom.createElement("div");
        dom.setAttribute(el1,"id","signUpPage");
        var el2 = dom.createTextNode("\n");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("br");
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("br");
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n");
        dom.appendChild(el1, el2);
        var el2 = dom.createElement("div");
        dom.setAttribute(el2,"class","ui grid container");
        var el3 = dom.createTextNode("\n  ");
        dom.appendChild(el2, el3);
        var el3 = dom.createElement("div");
        dom.setAttribute(el3,"class","ui one column stackable page grid");
        var el4 = dom.createTextNode("\n    ");
        dom.appendChild(el3, el4);
        var el4 = dom.createElement("div");
        dom.setAttribute(el4,"id","content");
        var el5 = dom.createTextNode("\n\n      ");
        dom.appendChild(el4, el5);
        var el5 = dom.createComment("");
        dom.appendChild(el4, el5);
        var el5 = dom.createTextNode("\n      ");
        dom.appendChild(el4, el5);
        var el5 = dom.createComment(" {{ emptyErrors }} ");
        dom.appendChild(el4, el5);
        var el5 = dom.createTextNode("\n\n\n    ");
        dom.appendChild(el4, el5);
        var el5 = dom.createElement("form");
        dom.setAttribute(el5,"class","ui error form inverted white segment");
        dom.setAttribute(el5,"id","signUpForm");
        var el6 = dom.createTextNode("\n\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","user icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","mail icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","info icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","info icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","lock icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("div");
        dom.setAttribute(el6,"class","required field");
        var el7 = dom.createTextNode("\n        ");
        dom.appendChild(el6, el7);
        var el7 = dom.createElement("div");
        dom.setAttribute(el7,"class","ui icon labeled input full-width");
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("div");
        dom.setAttribute(el8,"class","ui label icon");
        var el9 = dom.createTextNode("\n            ");
        dom.appendChild(el8, el9);
        var el9 = dom.createElement("i");
        dom.setAttribute(el9,"class","lock icon");
        dom.appendChild(el8, el9);
        var el9 = dom.createTextNode("\n          ");
        dom.appendChild(el8, el9);
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createComment("");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n          ");
        dom.appendChild(el7, el8);
        var el8 = dom.createElement("i");
        dom.setAttribute(el8,"class","warning red icon");
        dom.appendChild(el7, el8);
        var el8 = dom.createTextNode("\n        ");
        dom.appendChild(el7, el8);
        dom.appendChild(el6, el7);
        var el7 = dom.createTextNode("\n      ");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("br");
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n\n      ");
        dom.appendChild(el5, el6);
        var el6 = dom.createElement("button");
        dom.setAttribute(el6,"type","submit");
        dom.setAttribute(el6,"class","fluid green ui button");
        dom.setAttribute(el6,"style","text-align: right!important;");
        var el7 = dom.createTextNode("SignUp");
        dom.appendChild(el6, el7);
        dom.appendChild(el5, el6);
        var el6 = dom.createTextNode("\n    ");
        dom.appendChild(el5, el6);
        dom.appendChild(el4, el5);
        var el5 = dom.createTextNode("\n  ");
        dom.appendChild(el4, el5);
        dom.appendChild(el3, el4);
        var el4 = dom.createTextNode("\n");
        dom.appendChild(el3, el4);
        dom.appendChild(el2, el3);
        var el3 = dom.createTextNode("\n");
        dom.appendChild(el2, el3);
        dom.appendChild(el1, el2);
        var el2 = dom.createTextNode("\n\n");
        dom.appendChild(el1, el2);
        dom.appendChild(el0, el1);
        var el1 = dom.createTextNode("\n");
        dom.appendChild(el0, el1);
        return el0;
      },
      buildRenderNodes: function buildRenderNodes(dom, fragment, contextualElement) {
        var element0 = dom.childAt(fragment, [0, 5, 1, 1]);
        var element1 = dom.childAt(element0, [5]);
        var morphs = new Array(8);
        morphs[0] = dom.createMorphAt(element0,1,1);
        morphs[1] = dom.createElementMorph(element1);
        morphs[2] = dom.createMorphAt(dom.childAt(element1, [1, 1]),3,3);
        morphs[3] = dom.createMorphAt(dom.childAt(element1, [5, 1]),3,3);
        morphs[4] = dom.createMorphAt(dom.childAt(element1, [9, 1]),3,3);
        morphs[5] = dom.createMorphAt(dom.childAt(element1, [13, 1]),3,3);
        morphs[6] = dom.createMorphAt(dom.childAt(element1, [17, 1]),3,3);
        morphs[7] = dom.createMorphAt(dom.childAt(element1, [21, 1]),3,3);
        return morphs;
      },
      statements: [
        ["inline","messages-errors",[],["errors",["subexpr","@mut",[["get","model.errors",["loc",[null,[8,32],[8,44]]]]],[],[]]],["loc",[null,[8,6],[8,47]]]],
        ["element","action",["register"],["on","submit"],["loc",[null,[12,10],[12,43]]]],
        ["inline","input",[],["type","text","value",["subexpr","@mut",[["get","userName",["loc",[null,[19,37],[19,45]]]]],[],[]],"id","userName","placeholder","Username"],["loc",[null,[19,10],[19,85]]]],
        ["inline","input",[],["type","email","value",["subexpr","@mut",[["get","email",["loc",[null,[29,38],[29,43]]]]],[],[]],"id","email","placeholder","Email"],["loc",[null,[29,10],[29,77]]]],
        ["inline","input",[],["type","text","value",["subexpr","@mut",[["get","firstName",["loc",[null,[39,37],[39,46]]]]],[],[]],"id","firstName","placeholder","First Name"],["loc",[null,[39,10],[39,89]]]],
        ["inline","input",[],["type","text","value",["subexpr","@mut",[["get","lastName",["loc",[null,[49,37],[49,45]]]]],[],[]],"id","lastName","placeholder","Last Name"],["loc",[null,[49,10],[49,86]]]],
        ["inline","input",[],["type","password","value",["subexpr","@mut",[["get","password",["loc",[null,[59,40],[59,48]]]]],[],[]],"id","password","placeholder","Password"],["loc",[null,[59,10],[59,87]]]],
        ["inline","input",[],["type","password","value",["subexpr","@mut",[["get","passwordConfirmation",["loc",[null,[69,40],[69,60]]]]],[],[]],"id","passwordConfirmation","placeholder","Password Confirmation"],["loc",[null,[69,10],[69,124]]]]
      ],
      locals: [],
      templates: []
    };
  }()));

});