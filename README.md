﻿timeout_cache
=============

存放超时数据。
外部会进行查询，删除，插入操作。
数据超时会被删除。

前提：
	时间总是总第一个数据进入开始的时间作为起始点 firstTime。
	之后数据的timeou :now-firstTime+timout.
	这样无需更新每项的时间。

<<<<<<下面在git网页上看是乱码。。。下载打开看 是一张分析图表 >>>>>>>

//图为随时间偏移数据写入数

^(数据写入量)
|
|
|
|
|
|(每个时间写入的数据see down $(1))
|---------------------------------------------------------------------
|   
|      
|      (@1曲线)
|        。
|       。  。
|     。      。
|   。          。
| 。             。
|<a>------------<b>|--------------<c>|----------------<d>@|@---------------------------------------------@|@---->times

|<----------------------时间区间(one day)--------------->


$(1)随着时间增加会有数据写入，删除。短超时如几分钟会比较多。
	我们希望 <a-b>这个时间段数据尽量分布道<b-d>段中。越靠a分散的越快。以及计算的值会有随即抖动。振幅不定的波状。这样分散更能处理尖锐情况。
	像@1这样的将时间往后映射。这样数据会被散列到整个一天的表中。
	同理<b-c><c-d> 
	因为到<d>之后时间又被取模到<a-c>
这样超时的hash表效率会更高。

make


./test-release 1000000





2:cache 的超时处理使用一个链表实现的优先级队列。这个时候的插入耗时会比较久。最好是有链表的快速删除，插入和二分的快速查找。
平衡二叉树是个不错的选择。高效的二分。快速插入，快速删除。
跳跃表也不错。可以由不错的二分性能。
还有种方案是对时间进行time->array<item> 进行map,
对应时间到了就删除内部对应的项找出对应时间
这样做hash以后数据插入会快很多。但相对数据在删除的时候会慢点。


3:cache 的查询时使用hash表对队列的节点指针进行缓存。以达到外部的告诉查询，删除。


链表+hash（代码实现了）

1：对timeout 使用插入排序。
2：key->listnode 外部查询，删除。

跳跃表+hash （之后实现）

1：使用timeout建立跳跃表。
2：key-> treenode 外部查询

树+hash （之后实现）

1：使用timeout建立二叉树。
2：key-> treenode 外部查询

双hash（代码实现了）

1：key -> item 外部查询 删除 用。
2：timeout->item 内部超时使用。使用就近原则的hash用于分摊 优先队列的长度。