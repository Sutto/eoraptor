Date.prototype.setISO8601=function(b){var c="([0-9]{4})(-([0-9]{2})(-([0-9]{2})(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?";var f=b.match(new RegExp(c));var e=0;var a=new Date(f[1],0,1);if(f[3]){a.setMonth(f[3]-1)}if(f[5]){a.setDate(f[5])}if(f[7]){a.setHours(f[7])}if(f[8]){a.setMinutes(f[8])}if(f[10]){a.setSeconds(f[10])}if(f[12]){a.setMilliseconds(Number("0."+f[12])*1000)}if(f[14]){e=(Number(f[16])*60)+Number(f[17]);e*=((f[15]=="-")?1:-1)}e-=a.getTimezoneOffset();time=(Number(a)+(e*60*1000));this.setTime(Number(time))};var __indexOf=Array.prototype.indexOf||function(c){for(var b=0,a=this.length;b<a;b++){if(this[b]===c){return b}}return -1};Eoraptor.withNS("GitHub",function(a){var c,b;a.showCommits=function(f){var i,h,e,g,d;if(__indexOf.call(f,"commits")<0){return}a.commits=f.commits;a.container=$("#commit-listing");a.container.empty();g=a.commits.slice(0,10);d=[];for(h=0,e=g.length;h<e;h++){i=g[h];d.push(a.showCommit(i))}return d};b=function(d,e){return $("<span />",{"class":"gh-commit-"+d,html:e})};c=function(e){var d;d=new Date();d.setISO8601(e);return d};a.showCommit=function(g){var f,h,d,e;f=g.author;e=$("<li />",{"class":"github-commit"});f=$("<a />",{href:"http://github.com/"+f.login,text:f.name,"class":"gh-commit-author"});e.append(f);e.append(b("misc"," committed "));h=$("<a />",{href:g.url,html:Eoraptor.Util.truncate(g.message,45),"class":"gh-commit-message",title:g.message});e.append(h);e.append(b("misc"," about "));d=c(g.committed_date);({time:b("commited-at","")});Eoraptor.Util.attachUpdatingTimeAgo(time,d);e.append(time);e.append(b("misc"," ago."));return a.container.append(e)};a.commitsURL=function(){return"http://github.com/api/v2/json/commits/list/"+a.user+"/"+a.repository+"/master?callback="+(a.toNSName())+".showCommits"};a.loadCommits=function(){if((a.user!=null)&&(a.repository!=null)){return $.getScript(a.commitsURL())}};return a.setup=function(){a.user=$.metaAttr("github.user");a.repository=$.metaAttr("github.repository");return a.loadCommits()}});