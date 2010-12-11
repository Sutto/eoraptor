Eoraptor.withNS 'GitHub', (ns) ->

  ns.showCommits = (results) ->
    return unless results["commits"]?
    ns.commits   =   results.commits 
    ns.container = $ "#commit-listing"
    ns.container.empty()
    for commit in ns.commits.slice 0, 10
      ns.showCommit commit
      
  spanWithClass = (klass, content) ->
    $ "<span />", 'class': "gh-commit-#{klass}", 'html': content

  ghParseDate = (dateString) ->
    date = new Date()
    date.setISO8601 dateString
    date

  ns.showCommit = (commit) ->
    author = commit.author
    inner  = $ "<li />", 'class': 'github-commit'
    # Author Info    
    author = $ "<a />", 'href': "http://github.com/#{author.login}", 'text': author.name, 'class': 'gh-commit-author'
    inner.append author
    inner.append spanWithClass 'misc', ' committed '
    # Commit information
    commitLink = $ "<a />", 'href': commit.url, 'html': Eoraptor.Util.truncate(commit.message, 45), 'class': 'gh-commit-message', title: commit.message
    inner.append commitLink
    inner.append spanWithClass 'misc', ' about '
    
    commitedTime = ghParseDate commit.committed_date
    time = spanWithClass 'commited-at', ''
    Eoraptor.Util.attachUpdatingTimeAgo time, commitedTime
    inner.append time

    inner.append spanWithClass 'misc', ' ago.'
    ns.container.append inner
    
          
  ns.commitsURL = ->
    "http://github.com/api/v2/json/commits/list/#{ns.user}/#{ns.repository}/master?callback=#{ns.toNSName()}.showCommits"

  ns.loadCommits = () ->
    $.getScript ns.commitsURL() if ns.user? and ns.repository?

  ns.setup = ->
    ns.user       = $.metaAttr "github.user"
    ns.repository = $.metaAttr "github.repository"
    ns.loadCommits()