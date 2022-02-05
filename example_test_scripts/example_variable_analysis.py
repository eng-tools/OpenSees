# import custom_openseespy.opensees as ops
import sys
sys.path.insert(0, '../SRC/interpreter/')
import opensees as ops


ops.model('basic', '-ndm', 1, '-ndf', 1)
ops.uniaxialMaterial('Elastic', 1, 3000.0)

ops.node(1, 0.0)
ops.node(2, 72.0)

ops.fix(1, 1)

ops.element('Truss', 1, 1, 2, 10.0, 1)
ops.timeSeries('Linear', 1)
ops.pattern('Plain', 1, 1)
ops.load(2, 100.0)

ops.constraints('Transformation')
ops.numberer('ParallelPlain')
ops.test('NormDispIncr', 1e-6, 6, 2)
ops.system('ProfileSPD')
ops.integrator('Newmark', 0.5, 0.25)
# ops.analysis('Transient')
ops.algorithm('Linear')
ops.analysis('VariableTransient')

ops.analyze(1, 0.0001)
for i in range(30):
    # print(f'######################################## run {i} ##')
    # ops.analyze(10, 0.0001)
    ops.analyze(5, 0.0001, 0.00001, 0.0001, 10)
    print(f'time: {i} - ', ops.getTime())
# print('PPP')
# ops.analyze(20, 0.0001, 0.00001, 0.001, 5)
# print('time: ', ops.getTime())
# print('Node 4: ', [ops.nodeCoord(1), ops.nodeDisp(1)])
# print("COMPLETED")

# ops.stop()