# Fault-tolerant bank service

This project consisted in the implementation of a fault-tolerant service in **Java**, using the group communication protocol **Spread** - the service is a bank with a predefined number of accounts, over which can be performed several different operations.

In order to guarantee fault tolerance, it was implemented a **passive replication model**; to assure the resilience and persistence of data, each server has a built-in **HSQLDB database**; a **ReadWriteLock interface** was used to prevent race conditions between concurrent operations; the client can interact with the servers through an interface connected by **Atomix**.

The assignment was developed in the **Distributed Systems** profile of the Master's Degree (2020/21).

### Content

1. [Assignment](assignment.pdf)
2. [Code](code)
3. [Report](report.pdf)

## Contributors

![Hugo Cardoso][hugo-pic] | ![José Silva][ze-pic] | ![Pedro Rodrigues][areias-pic] | ![Válter Carvalho][valter-pic]
:---: | :---: | :---: | :---:
[Hugo Cardoso][hugo] | [José Silva][ze] | [Pedro Rodrigues][areias] | [Válter Carvalho][valter]

[areias]: https://github.com/pedrordgs
[areias-pic]: https://github.com/pedrordgs.png?size=120
[hugo]: https://github.com/Abjiri
[hugo-pic]: https://github.com/Abjiri.png?size=120
[valter]: https://github.com/wurzy
[valter-pic]: https://github.com/wurzy.png?size=120
[ze]: https://github.com/PedroSilva9
[ze-pic]: https://github.com/PedroSilva9.png?size=120
